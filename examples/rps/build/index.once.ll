#lang ll
parts {
  "A" = interact {
    commits = T_Fun [] T_Null,
    getHand = T_Fun [] T_Bytes,
    getParams = T_Fun [] (T_Tuple [T_UInt256,T_UInt256]),
    partnerIs = T_Fun [T_Address] T_Null,
    random = T_Fun [] T_UInt256,
    reveals = T_Fun [T_Bytes] T_Null},
  "B" = interact {
    acceptParams = T_Fun [T_UInt256,T_UInt256] T_Null,
    getHand = T_Fun [] T_Bytes,
    partnerIs = T_Fun [T_Address] T_Null,
    random = T_Fun [] T_UInt256,
    shows = T_Fun [] T_Null},
  "O" = interact {
    }};

only("A") {
  const "one of [\"wagerAmount\",\"escrowAmount\"] (as interact)":T_Tuple [T_UInt256,T_UInt256]:2 = interact("A")."getParams"();
  const "tuple idx":T_UInt256:3 = "one of [\"wagerAmount\",\"escrowAmount\"] (as interact)":T_Tuple [T_UInt256,T_UInt256]:2[0];
  const "tuple idx":T_UInt256:4 = "one of [\"wagerAmount\",\"escrowAmount\"] (as interact)":T_Tuple [T_UInt256,T_UInt256]:2[1];
   };
only("A") {
  const "prim":T_UInt256:8 = ADD("tuple idx":T_UInt256:3,"tuple idx":T_UInt256:4);
   };
publish("A", join("A":T_Address:7))("tuple idx":T_UInt256:3,"tuple idx":T_UInt256:4)("tuple idx":T_UInt256:5, "tuple idx":T_UInt256:6).pay("prim":T_UInt256:8){
  const "prim":T_UInt256:9 = ADD("tuple idx":T_UInt256:5,"tuple idx":T_UInt256:6);
  const "prim":T_UInt256:10 = TXN_VALUE();
  const "prim":T_Bool:11 = PEQ("prim":T_UInt256:9,"prim":T_UInt256:10);
  claim(CT_Require)("prim":T_Bool:11);
  commit();
  only("B") {
    const "interact":T_Null:13 = interact("B")."partnerIs"("A":T_Address:7);
    const "interact":T_Null:14 = interact("B")."acceptParams"("tuple idx":T_UInt256:5,"tuple idx":T_UInt256:6);
     };
  claim(CT_Require)(DLC_Bool True);
  only("B") {
     };
  publish("B", join("B":T_Address:15))()().pay("tuple idx":T_UInt256:5).timeout((DLC_Int 10, {
    only("A") {
       };
    publish("A", again("A":T_Address:7))()().pay(DLC_Int 0){
      const "prim":T_UInt256:23 = TXN_VALUE();
      const "prim":T_Bool:24 = PEQ(DLC_Int 0,"prim":T_UInt256:23);
      claim(CT_Require)("prim":T_Bool:24);
      const "prim":T_UInt256:25 = BALANCE();
      transfer.("prim":T_UInt256:25).to("A":T_Address:7);
      commit();
      exit(DLC_Bytes "Bob quits"); } })){
    const "prim":T_UInt256:16 = TXN_VALUE();
    const "prim":T_Bool:17 = PEQ("tuple idx":T_UInt256:5,"prim":T_UInt256:16);
    claim(CT_Require)("prim":T_Bool:17);
    commit();
    only("A") {
      const "interact":T_Null:27 = interact("A")."partnerIs"("B":T_Address:15);
      let "_handA (as clo app)":T_UInt256:29;
      const "s (as interact)":T_Bytes:30 = interact("A")."getHand"();
      const "rockP (as prim)":T_Bool:31 = BYTES_EQ("s (as interact)":T_Bytes:30,DLC_Bytes "ROCK");
      const "paperP (as prim)":T_Bool:32 = BYTES_EQ("s (as interact)":T_Bytes:30,DLC_Bytes "PAPER");
      const "scissorsP (as prim)":T_Bool:33 = BYTES_EQ("s (as interact)":T_Bytes:30,DLC_Bytes "SCISSORS");
      const "_handA (as prim)":T_Bool:35 = IF_THEN_ELSE("rockP (as prim)":T_Bool:31,DLC_Bool True,"paperP (as prim)":T_Bool:32);
      const "_handA (as prim)":T_Bool:37 = IF_THEN_ELSE("_handA (as prim)":T_Bool:35,DLC_Bool True,"scissorsP (as prim)":T_Bool:33);
      claim(CT_Assume)("_handA (as prim)":T_Bool:37);
      if "rockP (as prim)":T_Bool:31 then {
        "_handA (as clo app)":T_UInt256:29 = DLC_Int 0;
         }
      else {
        if "paperP (as prim)":T_Bool:32 then {
          "_handA (as clo app)":T_UInt256:29 = DLC_Int 1;
           }
        else {
          "_handA (as clo app)":T_UInt256:29 = DLC_Int 2;
           };
         };
      const "_handA (as prim)":T_Bool:40 = PLE(DLC_Int 0,"_handA (as clo app)":T_UInt256:29);
      const "_handA (as prim)":T_Bool:41 = PLT("_handA (as clo app)":T_UInt256:29,DLC_Int 3);
      const "_handA (as prim)":T_Bool:43 = IF_THEN_ELSE("_handA (as prim)":T_Bool:40,"_handA (as prim)":T_Bool:41,DLC_Bool False);
      claim(CT_Assert)("_handA (as prim)":T_Bool:43);
      const "salt (as interact)":T_UInt256:45 = interact("A")."random"();
      const "commitment (as digest)":T_UInt256:46 = digest("salt (as interact)":T_UInt256:45,"_handA (as clo app)":T_UInt256:29);
      const "interact":T_Null:47 = interact("A")."commits"();
       };
    claim(CT_Require)(DLC_Bool True);
    only("A") {
       };
    publish("A", again("A":T_Address:7))("commitment (as digest)":T_UInt256:46)("commitment (as digest)":T_UInt256:48).pay(DLC_Int 0).timeout((DLC_Int 10, {
      only("B") {
         };
      publish("B", again("B":T_Address:15))()().pay(DLC_Int 0){
        const "prim":T_UInt256:56 = TXN_VALUE();
        const "prim":T_Bool:57 = PEQ(DLC_Int 0,"prim":T_UInt256:56);
        claim(CT_Require)("prim":T_Bool:57);
        const "prim":T_UInt256:58 = BALANCE();
        transfer.("prim":T_UInt256:58).to("B":T_Address:15);
        commit();
        exit(DLC_Bytes "Alice quits"); } })){
      const "prim":T_UInt256:49 = TXN_VALUE();
      const "prim":T_Bool:50 = PEQ(DLC_Int 0,"prim":T_UInt256:49);
      claim(CT_Require)("prim":T_Bool:50);
      commit();
      only("B") {
        let "handB (as clo app)":T_UInt256:61;
        const "s (as interact)":T_Bytes:62 = interact("B")."getHand"();
        const "rockP (as prim)":T_Bool:63 = BYTES_EQ("s (as interact)":T_Bytes:62,DLC_Bytes "ROCK");
        const "paperP (as prim)":T_Bool:64 = BYTES_EQ("s (as interact)":T_Bytes:62,DLC_Bytes "PAPER");
        const "scissorsP (as prim)":T_Bool:65 = BYTES_EQ("s (as interact)":T_Bytes:62,DLC_Bytes "SCISSORS");
        const "handB (as prim)":T_Bool:67 = IF_THEN_ELSE("rockP (as prim)":T_Bool:63,DLC_Bool True,"paperP (as prim)":T_Bool:64);
        const "handB (as prim)":T_Bool:69 = IF_THEN_ELSE("handB (as prim)":T_Bool:67,DLC_Bool True,"scissorsP (as prim)":T_Bool:65);
        claim(CT_Assume)("handB (as prim)":T_Bool:69);
        if "rockP (as prim)":T_Bool:63 then {
          "handB (as clo app)":T_UInt256:61 = DLC_Int 0;
           }
        else {
          if "paperP (as prim)":T_Bool:64 then {
            "handB (as clo app)":T_UInt256:61 = DLC_Int 1;
             }
          else {
            "handB (as clo app)":T_UInt256:61 = DLC_Int 2;
             };
           };
        const "handB (as prim)":T_Bool:72 = PLE(DLC_Int 0,"handB (as clo app)":T_UInt256:61);
        const "handB (as prim)":T_Bool:73 = PLT("handB (as clo app)":T_UInt256:61,DLC_Int 3);
        const "handB (as prim)":T_Bool:75 = IF_THEN_ELSE("handB (as prim)":T_Bool:72,"handB (as prim)":T_Bool:73,DLC_Bool False);
        claim(CT_Assert)("handB (as prim)":T_Bool:75);
        const "interact":T_Null:76 = interact("B")."shows"();
         };
      claim(CT_Require)(DLC_Bool True);
      only("B") {
         };
      publish("B", again("B":T_Address:15))("handB (as clo app)":T_UInt256:61)("handB (as clo app)":T_UInt256:77).pay(DLC_Int 0).timeout((DLC_Int 10, {
        only("A") {
           };
        publish("A", again("A":T_Address:7))()().pay(DLC_Int 0){
          const "prim":T_UInt256:85 = TXN_VALUE();
          const "prim":T_Bool:86 = PEQ(DLC_Int 0,"prim":T_UInt256:85);
          claim(CT_Require)("prim":T_Bool:86);
          const "prim":T_UInt256:87 = BALANCE();
          transfer.("prim":T_UInt256:87).to("A":T_Address:7);
          commit();
          exit(DLC_Bytes "Bob quits"); } })){
        const "prim":T_UInt256:78 = TXN_VALUE();
        const "prim":T_Bool:79 = PEQ(DLC_Int 0,"prim":T_UInt256:78);
        claim(CT_Require)("prim":T_Bool:79);
        const "prim":T_Bool:89 = PLE(DLC_Int 0,"handB (as clo app)":T_UInt256:77);
        const "prim":T_Bool:90 = PLT("handB (as clo app)":T_UInt256:77,DLC_Int 3);
        const "prim":T_Bool:92 = IF_THEN_ELSE("prim":T_Bool:89,"prim":T_Bool:90,DLC_Bool False);
        claim(CT_Require)("prim":T_Bool:92);
        commit();
        only("A") {
          let "clo app":T_Bytes:94;
          const "prim":T_Bool:96 = PLE(DLC_Int 0,"handB (as clo app)":T_UInt256:77);
          const "prim":T_Bool:97 = PLT("handB (as clo app)":T_UInt256:77,DLC_Int 3);
          const "prim":T_Bool:99 = IF_THEN_ELSE("prim":T_Bool:96,"prim":T_Bool:97,DLC_Bool False);
          claim(CT_Require)("prim":T_Bool:99);
          const "prim":T_Bool:100 = PEQ("handB (as clo app)":T_UInt256:77,DLC_Int 0);
          if "prim":T_Bool:100 then {
            "clo app":T_Bytes:94 = DLC_Bytes "ROCK";
             }
          else {
            const "prim":T_Bool:101 = PEQ("handB (as clo app)":T_UInt256:77,DLC_Int 1);
            if "prim":T_Bool:101 then {
              "clo app":T_Bytes:94 = DLC_Bytes "PAPER";
               }
            else {
              "clo app":T_Bytes:94 = DLC_Bytes "SCISSORS";
               };
             };
          const "interact":T_Null:102 = interact("A")."reveals"("clo app":T_Bytes:94);
           };
        claim(CT_Require)(DLC_Bool True);
        only("A") {
           };
        publish("A", again("A":T_Address:7))("salt (as interact)":T_UInt256:45,"_handA (as clo app)":T_UInt256:29)("salt (as interact)":T_UInt256:103, "_handA (as clo app)":T_UInt256:104).pay(DLC_Int 0).timeout((DLC_Int 10, {
          only("B") {
             };
          publish("B", again("B":T_Address:15))()().pay(DLC_Int 0){
            const "prim":T_UInt256:112 = TXN_VALUE();
            const "prim":T_Bool:113 = PEQ(DLC_Int 0,"prim":T_UInt256:112);
            claim(CT_Require)("prim":T_Bool:113);
            const "prim":T_UInt256:114 = BALANCE();
            transfer.("prim":T_UInt256:114).to("B":T_Address:15);
            commit();
            exit(DLC_Bytes "Alice quits"); } })){
          const "prim":T_UInt256:105 = TXN_VALUE();
          const "prim":T_Bool:106 = PEQ(DLC_Int 0,"prim":T_UInt256:105);
          claim(CT_Require)("prim":T_Bool:106);
          const "digest":T_UInt256:116 = digest("salt (as interact)":T_UInt256:103,"_handA (as clo app)":T_UInt256:104);
          const "prim":T_Bool:117 = PEQ("commitment (as digest)":T_UInt256:48,"digest":T_UInt256:116);
          claim(CT_Require)("prim":T_Bool:117);
          const "prim":T_Bool:119 = PLE(DLC_Int 0,"_handA (as clo app)":T_UInt256:104);
          const "prim":T_Bool:120 = PLT("_handA (as clo app)":T_UInt256:104,DLC_Int 3);
          const "prim":T_Bool:122 = IF_THEN_ELSE("prim":T_Bool:119,"prim":T_Bool:120,DLC_Bool False);
          claim(CT_Require)("prim":T_Bool:122);
          let "outcome (as clo app)":T_UInt256:124;
          const "validA (as prim)":T_Bool:126 = PLE(DLC_Int 0,"_handA (as clo app)":T_UInt256:104);
          const "validA (as prim)":T_Bool:127 = PLT("_handA (as clo app)":T_UInt256:104,DLC_Int 3);
          const "validA (as prim)":T_Bool:129 = IF_THEN_ELSE("validA (as prim)":T_Bool:126,"validA (as prim)":T_Bool:127,DLC_Bool False);
          const "validB (as prim)":T_Bool:131 = PLE(DLC_Int 0,"handB (as clo app)":T_UInt256:77);
          const "validB (as prim)":T_Bool:132 = PLT("handB (as clo app)":T_UInt256:77,DLC_Int 3);
          const "validB (as prim)":T_Bool:134 = IF_THEN_ELSE("validB (as prim)":T_Bool:131,"validB (as prim)":T_Bool:132,DLC_Bool False);
          const "outcome (as prim)":T_Bool:136 = IF_THEN_ELSE("validA (as prim)":T_Bool:129,"validB (as prim)":T_Bool:134,DLC_Bool False);
          if "outcome (as prim)":T_Bool:136 then {
            const "outcome (as prim)":T_UInt256:137 = SUB(DLC_Int 4,"handB (as clo app)":T_UInt256:77);
            const "outcome (as prim)":T_UInt256:138 = ADD("_handA (as clo app)":T_UInt256:104,"outcome (as prim)":T_UInt256:137);
            const "outcome (as prim)":T_UInt256:139 = MOD("outcome (as prim)":T_UInt256:138,DLC_Int 3);
            "outcome (as clo app)":T_UInt256:124 = "outcome (as prim)":T_UInt256:139;
             }
          else {
            if "validA (as prim)":T_Bool:129 then {
              "outcome (as clo app)":T_UInt256:124 = DLC_Int 2;
               }
            else {
              if "validB (as prim)":T_Bool:134 then {
                "outcome (as clo app)":T_UInt256:124 = DLC_Int 0;
                 }
              else {
                "outcome (as clo app)":T_UInt256:124 = DLC_Int 1;
                 };
               };
             };
          const "outcome (as prim)":T_Bool:142 = PLE(DLC_Int 0,"outcome (as clo app)":T_UInt256:124);
          const "outcome (as prim)":T_Bool:143 = PLT("outcome (as clo app)":T_UInt256:124,DLC_Int 5);
          const "outcome (as prim)":T_Bool:145 = IF_THEN_ELSE("outcome (as prim)":T_Bool:142,"outcome (as prim)":T_Bool:143,DLC_Bool False);
          claim(CT_Assert)("outcome (as prim)":T_Bool:145);
          const "prim":T_Bool:146 = PEQ("outcome (as clo app)":T_UInt256:124,DLC_Int 2);
          const "prim":T_Bool:148 = PLE(DLC_Int 0,"_handA (as clo app)":T_UInt256:104);
          const "prim":T_Bool:149 = PLT("_handA (as clo app)":T_UInt256:104,DLC_Int 3);
          const "prim":T_Bool:151 = IF_THEN_ELSE("prim":T_Bool:148,"prim":T_Bool:149,DLC_Bool False);
          const "prim":T_Bool:154 = IF_THEN_ELSE("prim":T_Bool:146,DLC_Bool False,DLC_Bool True);
          const "prim":T_Bool:156 = IF_THEN_ELSE("prim":T_Bool:154,DLC_Bool True,"prim":T_Bool:151);
          claim(CT_Assert)("prim":T_Bool:156);
          const "prim":T_Bool:157 = PEQ("outcome (as clo app)":T_UInt256:124,DLC_Int 0);
          const "prim":T_Bool:159 = PLE(DLC_Int 0,"handB (as clo app)":T_UInt256:77);
          const "prim":T_Bool:160 = PLT("handB (as clo app)":T_UInt256:77,DLC_Int 3);
          const "prim":T_Bool:162 = IF_THEN_ELSE("prim":T_Bool:159,"prim":T_Bool:160,DLC_Bool False);
          const "prim":T_Bool:165 = IF_THEN_ELSE("prim":T_Bool:157,DLC_Bool False,DLC_Bool True);
          const "prim":T_Bool:167 = IF_THEN_ELSE("prim":T_Bool:165,DLC_Bool True,"prim":T_Bool:162);
          claim(CT_Assert)("prim":T_Bool:167);
          const "prim":T_Bool:169 = PEQ("outcome (as clo app)":T_UInt256:124,DLC_Int 2);
          const "prim":T_Bool:172 = PEQ("_handA (as clo app)":T_UInt256:104,DLC_Int 0);
          const "prim":T_Bool:174 = IF_THEN_ELSE("prim":T_Bool:172,"prim":T_Bool:169,DLC_Bool False);
          claim(CT_Possible)("prim":T_Bool:174);
          const "prim":T_Bool:176 = PEQ("_handA (as clo app)":T_UInt256:104,DLC_Int 1);
          const "prim":T_Bool:178 = IF_THEN_ELSE("prim":T_Bool:176,"prim":T_Bool:169,DLC_Bool False);
          claim(CT_Possible)("prim":T_Bool:178);
          const "prim":T_Bool:180 = PEQ("_handA (as clo app)":T_UInt256:104,DLC_Int 2);
          const "prim":T_Bool:182 = IF_THEN_ELSE("prim":T_Bool:180,"prim":T_Bool:169,DLC_Bool False);
          claim(CT_Possible)("prim":T_Bool:182);
          const "prim":T_Bool:183 = PEQ("outcome (as clo app)":T_UInt256:124,DLC_Int 0);
          const "prim":T_Bool:186 = PEQ("handB (as clo app)":T_UInt256:77,DLC_Int 0);
          const "prim":T_Bool:188 = IF_THEN_ELSE("prim":T_Bool:186,"prim":T_Bool:183,DLC_Bool False);
          claim(CT_Possible)("prim":T_Bool:188);
          const "prim":T_Bool:190 = PEQ("handB (as clo app)":T_UInt256:77,DLC_Int 1);
          const "prim":T_Bool:192 = IF_THEN_ELSE("prim":T_Bool:190,"prim":T_Bool:183,DLC_Bool False);
          claim(CT_Possible)("prim":T_Bool:192);
          const "prim":T_Bool:194 = PEQ("handB (as clo app)":T_UInt256:77,DLC_Int 2);
          const "prim":T_Bool:196 = IF_THEN_ELSE("prim":T_Bool:194,"prim":T_Bool:183,DLC_Bool False);
          claim(CT_Possible)("prim":T_Bool:196);
          let "one of [\"getsA\",\"getsB\"] (as clo app)":T_Tuple [T_UInt256,T_UInt256]:197;
          const "one of [\"getsA\",\"getsB\"] (as prim)":T_Bool:198 = PEQ("outcome (as clo app)":T_UInt256:124,DLC_Int 2);
          if "one of [\"getsA\",\"getsB\"] (as prim)":T_Bool:198 then {
            const "one of [\"getsA\",\"getsB\"] (as prim)":T_UInt256:199 = MUL(DLC_Int 2,"tuple idx":T_UInt256:5);
            "one of [\"getsA\",\"getsB\"] (as clo app)":T_Tuple [T_UInt256,T_UInt256]:197 = ["one of [\"getsA\",\"getsB\"] (as prim)":T_UInt256:199,DLC_Int 0];
             }
          else {
            const "one of [\"getsA\",\"getsB\"] (as prim)":T_Bool:200 = PEQ("outcome (as clo app)":T_UInt256:124,DLC_Int 0);
            if "one of [\"getsA\",\"getsB\"] (as prim)":T_Bool:200 then {
              const "one of [\"getsA\",\"getsB\"] (as prim)":T_UInt256:201 = MUL(DLC_Int 2,"tuple idx":T_UInt256:5);
              "one of [\"getsA\",\"getsB\"] (as clo app)":T_Tuple [T_UInt256,T_UInt256]:197 = [DLC_Int 0,"one of [\"getsA\",\"getsB\"] (as prim)":T_UInt256:201];
               }
            else {
              "one of [\"getsA\",\"getsB\"] (as clo app)":T_Tuple [T_UInt256,T_UInt256]:197 = ["tuple idx":T_UInt256:5,"tuple idx":T_UInt256:5];
               };
             };
          const "tuple idx":T_UInt256:202 = "one of [\"getsA\",\"getsB\"] (as clo app)":T_Tuple [T_UInt256,T_UInt256]:197[0];
          const "tuple idx":T_UInt256:203 = "one of [\"getsA\",\"getsB\"] (as clo app)":T_Tuple [T_UInt256,T_UInt256]:197[1];
          const "prim":T_UInt256:204 = ADD("tuple idx":T_UInt256:6,"tuple idx":T_UInt256:202);
          transfer.("prim":T_UInt256:204).to("A":T_Address:7);
          transfer.("tuple idx":T_UInt256:203).to("B":T_Address:15);
          commit();
          let "clo app":T_Bytes:205;
          const "prim":T_Bool:207 = PLE(DLC_Int 0,"outcome (as clo app)":T_UInt256:124);
          const "prim":T_Bool:208 = PLT("outcome (as clo app)":T_UInt256:124,DLC_Int 5);
          const "prim":T_Bool:210 = IF_THEN_ELSE("prim":T_Bool:207,"prim":T_Bool:208,DLC_Bool False);
          claim(CT_Require)("prim":T_Bool:210);
          const "prim":T_Bool:211 = PEQ("outcome (as clo app)":T_UInt256:124,DLC_Int 0);
          if "prim":T_Bool:211 then {
            "clo app":T_Bytes:205 = DLC_Bytes "Bob wins";
             }
          else {
            const "prim":T_Bool:212 = PEQ("outcome (as clo app)":T_UInt256:124,DLC_Int 1);
            if "prim":T_Bool:212 then {
              "clo app":T_Bytes:205 = DLC_Bytes "Draw";
               }
            else {
              const "prim":T_Bool:213 = PEQ("outcome (as clo app)":T_UInt256:124,DLC_Int 2);
              if "prim":T_Bool:213 then {
                "clo app":T_Bytes:205 = DLC_Bytes "Alice wins";
                 }
              else {
                const "prim":T_Bool:214 = PEQ("outcome (as clo app)":T_UInt256:124,DLC_Int 3);
                if "prim":T_Bool:214 then {
                  "clo app":T_Bytes:205 = DLC_Bytes "Alice quits";
                   }
                else {
                  "clo app":T_Bytes:205 = DLC_Bytes "Bob quits";
                   };
                 };
               };
             };
          exit("clo app":T_Bytes:205); } } } } }