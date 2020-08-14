#lang pl
{
  "A" = interact {
    commits = T_Fun [] T_Null,
    endsWith = T_Fun [T_Bytes] T_Null,
    getHand = T_Fun [] T_Bytes,
    getParams = T_Fun [] (T_Tuple [T_UInt256,T_UInt256]),
    partnerIs = T_Fun [T_Address] T_Null,
    random = T_Fun [] T_UInt256,
    reveals = T_Fun [T_Bytes] T_Null};
  const *v2 = interact("A")."getParams"();
  const *v3 = v2[0];
  const *v4 = v2[1];
  
  const !v8 = ADD(v3,v4);
  
  sendrecv join(v7) 1 (.publish((v3,v4), v8, ()))(v5, v6){
    const !v9 = ADD(v5,v6);
    const !v10 = TXN_VALUE();
    const !v11 = PEQ(v9,v10);
    claim(CT_Require)(v11);
    sendrecv join(v15) 2 ()().timeout(DLC_Int 10, {
      
      sendrecv again(v7) 14 (.publish((), DLC_Int 0, (v7, v5, v6)))(){
        const !v20 = TXN_VALUE();
        const !v21 = PEQ(DLC_Int 0,v20);
        claim(CT_Require)(v21);
        claim(CT_Require)(DLC_Bool True);
        eff interact("A")."endsWith"(DLC_Bytes "Bob quits");
        
         } }){
      const !v16 = TXN_VALUE();
      const !v17 = PEQ(v5,v16);
      claim(CT_Require)(v17);
      eff interact("A")."partnerIs"(v15);
      
      
      sendrecv again(v7) 3 (.publish((), DLC_Int 0, (v7, v5, v6, v15)))().timeout(DLC_Int 10, {
        sendrecv again(v15) 13 ()(){
          const !v40 = TXN_VALUE();
          const !v41 = PEQ(DLC_Int 0,v40);
          claim(CT_Require)(v41);
          claim(CT_Require)(DLC_Bool True);
          eff interact("A")."endsWith"(DLC_Bytes "Alice quits");
          
           } }){
        const !v36 = TXN_VALUE();
        const !v37 = PEQ(DLC_Int 0,v36);
        claim(CT_Require)(v37);
        loopvar {
          v54 = DLC_Int 0,
          v55 = DLC_Int 1};
        invariant{
          () }
        while{
          (begin const !v79 = PEQ(v55,DLC_Int 1);
           v79) }
        {
          let v83;
          const *v84 = interact("A")."getHand"();
          const *v85 = BYTES_EQ(v84,DLC_Bytes "ROCK");
          const *v86 = BYTES_EQ(v84,DLC_Bytes "PAPER");
          const !v87 = BYTES_EQ(v84,DLC_Bytes "SCISSORS");
          const !v89 = IF_THEN_ELSE(v85,DLC_Bool True,v86);
          const !v91 = IF_THEN_ELSE(v89,DLC_Bool True,v87);
          claim(CT_Assume)(v91);
          if v85 then {
            v83 = DLC_Int 0;
             }
          else {
            if v86 then {
              v83 = DLC_Int 1;
               }
            else {
              v83 = DLC_Int 2;
               };
             };
          const *v99 = interact("A")."random"();
          const !v100 = digest(v99,v83);
          eff interact("A")."commits"();
          
          
          sendrecv again(v7) 5 (.publish((v100), DLC_Int 0, (v7, v5, v6, v15, v54)))(v102).timeout(DLC_Int 10, {
            sendrecv again(v15) 12 ()(){
              const !v107 = TXN_VALUE();
              const !v108 = PEQ(DLC_Int 0,v107);
              claim(CT_Require)(v108);
              claim(CT_Require)(DLC_Bool True);
              eff interact("A")."endsWith"(DLC_Bytes "Alice quits");
              
               } }){
            const !v103 = TXN_VALUE();
            const !v104 = PEQ(DLC_Int 0,v103);
            claim(CT_Require)(v104);
            sendrecv again(v15) 6 ()(v139).timeout(DLC_Int 10, {
              
              sendrecv again(v7) 11 (.publish((), DLC_Int 0, (v7, v5, v6, v15, v102, v54)))(){
                const !v144 = TXN_VALUE();
                const !v145 = PEQ(DLC_Int 0,v144);
                claim(CT_Require)(v145);
                claim(CT_Require)(DLC_Bool True);
                eff interact("A")."endsWith"(DLC_Bytes "Bob quits");
                
                 } }){
              const !v140 = TXN_VALUE();
              const !v141 = PEQ(DLC_Int 0,v140);
              claim(CT_Require)(v141);
              const !v159 = PLE(DLC_Int 0,v139);
              const !v160 = PLT(v139,DLC_Int 3);
              const !v162 = IF_THEN_ELSE(v159,v160,DLC_Bool False);
              claim(CT_Require)(v162);
              let v164;
              const !v166 = PLE(DLC_Int 0,v139);
              const !v167 = PLT(v139,DLC_Int 3);
              const !v169 = IF_THEN_ELSE(v166,v167,DLC_Bool False);
              claim(CT_Require)(v169);
              const !v170 = PEQ(v139,DLC_Int 0);
              if v170 then {
                v164 = DLC_Bytes "ROCK";
                 }
              else {
                const !v171 = PEQ(v139,DLC_Int 1);
                if v171 then {
                  v164 = DLC_Bytes "PAPER";
                   }
                else {
                  v164 = DLC_Bytes "SCISSORS";
                   };
                 };
              eff interact("A")."reveals"(v164);
              
              
              sendrecv again(v7) 7 (.publish((v99,v83), DLC_Int 0, (v7, v5, v6, v15, v102, v139, v54)))(v173, v174).timeout(DLC_Int 10, {
                sendrecv again(v15) 10 ()(){
                  const !v179 = TXN_VALUE();
                  const !v180 = PEQ(DLC_Int 0,v179);
                  claim(CT_Require)(v180);
                  claim(CT_Require)(DLC_Bool True);
                  eff interact("A")."endsWith"(DLC_Bytes "Alice quits");
                  
                   } }){
                const !v175 = TXN_VALUE();
                const !v176 = PEQ(DLC_Int 0,v175);
                claim(CT_Require)(v176);
                const !v194 = digest(v173,v174);
                const !v195 = PEQ(v102,v194);
                claim(CT_Require)(v195);
                const !v197 = PLE(DLC_Int 0,v174);
                const !v198 = PLT(v174,DLC_Int 3);
                const !v200 = IF_THEN_ELSE(v197,v198,DLC_Bool False);
                claim(CT_Require)(v200);
                let v202;
                const !v204 = PLE(DLC_Int 0,v174);
                const !v205 = PLT(v174,DLC_Int 3);
                const *v207 = IF_THEN_ELSE(v204,v205,DLC_Bool False);
                const !v209 = PLE(DLC_Int 0,v139);
                const !v210 = PLT(v139,DLC_Int 3);
                const *v212 = IF_THEN_ELSE(v209,v210,DLC_Bool False);
                const !v214 = IF_THEN_ELSE(v207,v212,DLC_Bool False);
                if v214 then {
                  const !v215 = SUB(DLC_Int 4,v139);
                  const !v216 = ADD(v174,v215);
                  const !v217 = MOD(v216,DLC_Int 3);
                  v202 = v217;
                   }
                else {
                  if v207 then {
                    v202 = DLC_Int 2;
                     }
                  else {
                    if v212 then {
                      v202 = DLC_Int 0;
                       }
                    else {
                      v202 = DLC_Int 1;
                       };
                     };
                   };
                sendrecv again(v15) 8 ()().timeout(DLC_Int 10, {
                  
                  sendrecv again(v7) 9 (.publish((), DLC_Int 0, (v202, v7, v5, v6, v15, v54)))(){
                    const !v279 = TXN_VALUE();
                    const !v280 = PEQ(DLC_Int 0,v279);
                    claim(CT_Require)(v280);
                    claim(CT_Require)(DLC_Bool True);
                    eff interact("A")."endsWith"(DLC_Bytes "Bob quits");
                    
                     } }){
                  const !v275 = TXN_VALUE();
                  const !v276 = PEQ(DLC_Int 0,v275);
                  claim(CT_Require)(v276);
                  const !v293 = ADD(DLC_Int 1,v54);
                  {
                    v54 = v293,
                    v55 = v202}
                  continue; } } } } }
        let v299;
        const !v300 = PEQ(v55,DLC_Int 2);
        if v300 then {
          const !v301 = MUL(DLC_Int 2,v5);
          v299 = [v301,DLC_Int 0];
           }
        else {
          const !v302 = PEQ(v55,DLC_Int 0);
          if v302 then {
            const !v303 = MUL(DLC_Int 2,v5);
            v299 = [DLC_Int 0,v303];
             }
          else {
            v299 = [v5,v5];
             };
           };
        let v310;
        const !v312 = PLE(DLC_Int 0,v55);
        const !v313 = PLT(v55,DLC_Int 5);
        const !v315 = IF_THEN_ELSE(v312,v313,DLC_Bool False);
        claim(CT_Require)(v315);
        const !v316 = PEQ(v55,DLC_Int 0);
        if v316 then {
          v310 = DLC_Bytes "Bob wins";
           }
        else {
          const !v317 = PEQ(v55,DLC_Int 1);
          if v317 then {
            v310 = DLC_Bytes "Draw";
             }
          else {
            const !v318 = PEQ(v55,DLC_Int 2);
            if v318 then {
              v310 = DLC_Bytes "Alice wins";
               }
            else {
              const !v319 = PEQ(v55,DLC_Int 3);
              if v319 then {
                v310 = DLC_Bytes "Alice quits";
                 }
              else {
                v310 = DLC_Bytes "Bob quits";
                 };
               };
             };
           };
        eff interact("A")."endsWith"(v310);
        
         } } },
  "B" = interact {
    acceptParams = T_Fun [T_UInt256,T_UInt256] T_Null,
    endsWith = T_Fun [T_Bytes] T_Null,
    getHand = T_Fun [] T_Bytes,
    partnerIs = T_Fun [T_Address] T_Null,
    random = T_Fun [] T_UInt256,
    shows = T_Fun [] T_Null};
  sendrecv join(v7) 1 ()(v5, v6){
    const !v9 = ADD(v5,v6);
    const !v10 = TXN_VALUE();
    const !v11 = PEQ(v9,v10);
    claim(CT_Require)(v11);
    eff interact("B")."partnerIs"(v7);
    eff interact("B")."acceptParams"(v5,v6);
    
    
    sendrecv join(v15) 2 (.publish((), v5, (v7, v5, v6)))().timeout(DLC_Int 10, {
      sendrecv again(v7) 14 ()(){
        const !v20 = TXN_VALUE();
        const !v21 = PEQ(DLC_Int 0,v20);
        claim(CT_Require)(v21);
        claim(CT_Require)(DLC_Bool True);
        eff interact("B")."endsWith"(DLC_Bytes "Bob quits");
        
         } }){
      const !v16 = TXN_VALUE();
      const !v17 = PEQ(v5,v16);
      claim(CT_Require)(v17);
      sendrecv again(v7) 3 ()().timeout(DLC_Int 10, {
        
        sendrecv again(v15) 13 (.publish((), DLC_Int 0, (v7, v5, v6, v15)))(){
          const !v40 = TXN_VALUE();
          const !v41 = PEQ(DLC_Int 0,v40);
          claim(CT_Require)(v41);
          claim(CT_Require)(DLC_Bool True);
          eff interact("B")."endsWith"(DLC_Bytes "Alice quits");
          
           } }){
        const !v36 = TXN_VALUE();
        const !v37 = PEQ(DLC_Int 0,v36);
        claim(CT_Require)(v37);
        loopvar {
          v54 = DLC_Int 0,
          v55 = DLC_Int 1};
        invariant{
          () }
        while{
          (begin const !v79 = PEQ(v55,DLC_Int 1);
           v79) }
        {
          sendrecv again(v7) 5 ()(v102).timeout(DLC_Int 10, {
            
            sendrecv again(v15) 12 (.publish((), DLC_Int 0, (v7, v5, v6, v15, v54)))(){
              const !v107 = TXN_VALUE();
              const !v108 = PEQ(DLC_Int 0,v107);
              claim(CT_Require)(v108);
              claim(CT_Require)(DLC_Bool True);
              eff interact("B")."endsWith"(DLC_Bytes "Alice quits");
              
               } }){
            const !v103 = TXN_VALUE();
            const !v104 = PEQ(DLC_Int 0,v103);
            claim(CT_Require)(v104);
            let v123;
            const *v124 = interact("B")."getHand"();
            const *v125 = BYTES_EQ(v124,DLC_Bytes "ROCK");
            const *v126 = BYTES_EQ(v124,DLC_Bytes "PAPER");
            const !v127 = BYTES_EQ(v124,DLC_Bytes "SCISSORS");
            const !v129 = IF_THEN_ELSE(v125,DLC_Bool True,v126);
            const !v131 = IF_THEN_ELSE(v129,DLC_Bool True,v127);
            claim(CT_Assume)(v131);
            if v125 then {
              v123 = DLC_Int 0;
               }
            else {
              if v126 then {
                v123 = DLC_Int 1;
                 }
              else {
                v123 = DLC_Int 2;
                 };
               };
            eff interact("B")."shows"();
            
            
            sendrecv again(v15) 6 (.publish((v123), DLC_Int 0, (v7, v5, v6, v15, v102, v54)))(v139).timeout(DLC_Int 10, {
              sendrecv again(v7) 11 ()(){
                const !v144 = TXN_VALUE();
                const !v145 = PEQ(DLC_Int 0,v144);
                claim(CT_Require)(v145);
                claim(CT_Require)(DLC_Bool True);
                eff interact("B")."endsWith"(DLC_Bytes "Bob quits");
                
                 } }){
              const !v140 = TXN_VALUE();
              const !v141 = PEQ(DLC_Int 0,v140);
              claim(CT_Require)(v141);
              const !v159 = PLE(DLC_Int 0,v139);
              const !v160 = PLT(v139,DLC_Int 3);
              const !v162 = IF_THEN_ELSE(v159,v160,DLC_Bool False);
              claim(CT_Require)(v162);
              sendrecv again(v7) 7 ()(v173, v174).timeout(DLC_Int 10, {
                
                sendrecv again(v15) 10 (.publish((), DLC_Int 0, (v7, v5, v6, v15, v102, v139, v54)))(){
                  const !v179 = TXN_VALUE();
                  const !v180 = PEQ(DLC_Int 0,v179);
                  claim(CT_Require)(v180);
                  claim(CT_Require)(DLC_Bool True);
                  eff interact("B")."endsWith"(DLC_Bytes "Alice quits");
                  
                   } }){
                const !v175 = TXN_VALUE();
                const !v176 = PEQ(DLC_Int 0,v175);
                claim(CT_Require)(v176);
                const !v194 = digest(v173,v174);
                const !v195 = PEQ(v102,v194);
                claim(CT_Require)(v195);
                const !v197 = PLE(DLC_Int 0,v174);
                const !v198 = PLT(v174,DLC_Int 3);
                const !v200 = IF_THEN_ELSE(v197,v198,DLC_Bool False);
                claim(CT_Require)(v200);
                let v202;
                const !v204 = PLE(DLC_Int 0,v174);
                const !v205 = PLT(v174,DLC_Int 3);
                const *v207 = IF_THEN_ELSE(v204,v205,DLC_Bool False);
                const !v209 = PLE(DLC_Int 0,v139);
                const !v210 = PLT(v139,DLC_Int 3);
                const *v212 = IF_THEN_ELSE(v209,v210,DLC_Bool False);
                const !v214 = IF_THEN_ELSE(v207,v212,DLC_Bool False);
                if v214 then {
                  const !v215 = SUB(DLC_Int 4,v139);
                  const !v216 = ADD(v174,v215);
                  const !v217 = MOD(v216,DLC_Int 3);
                  v202 = v217;
                   }
                else {
                  if v207 then {
                    v202 = DLC_Int 2;
                     }
                  else {
                    if v212 then {
                      v202 = DLC_Int 0;
                       }
                    else {
                      v202 = DLC_Int 1;
                       };
                     };
                   };
                
                sendrecv again(v15) 8 (.publish((), DLC_Int 0, (v202, v7, v5, v6, v15, v54)))().timeout(DLC_Int 10, {
                  sendrecv again(v7) 9 ()(){
                    const !v279 = TXN_VALUE();
                    const !v280 = PEQ(DLC_Int 0,v279);
                    claim(CT_Require)(v280);
                    claim(CT_Require)(DLC_Bool True);
                    eff interact("B")."endsWith"(DLC_Bytes "Bob quits");
                    
                     } }){
                  const !v275 = TXN_VALUE();
                  const !v276 = PEQ(DLC_Int 0,v275);
                  claim(CT_Require)(v276);
                  const !v293 = ADD(DLC_Int 1,v54);
                  {
                    v54 = v293,
                    v55 = v202}
                  continue; } } } } }
        let v299;
        const !v300 = PEQ(v55,DLC_Int 2);
        if v300 then {
          const !v301 = MUL(DLC_Int 2,v5);
          v299 = [v301,DLC_Int 0];
           }
        else {
          const !v302 = PEQ(v55,DLC_Int 0);
          if v302 then {
            const !v303 = MUL(DLC_Int 2,v5);
            v299 = [DLC_Int 0,v303];
             }
          else {
            v299 = [v5,v5];
             };
           };
        let v322;
        const !v324 = PLE(DLC_Int 0,v55);
        const !v325 = PLT(v55,DLC_Int 5);
        const !v327 = IF_THEN_ELSE(v324,v325,DLC_Bool False);
        claim(CT_Require)(v327);
        const !v328 = PEQ(v55,DLC_Int 0);
        if v328 then {
          v322 = DLC_Bytes "Bob wins";
           }
        else {
          const !v329 = PEQ(v55,DLC_Int 1);
          if v329 then {
            v322 = DLC_Bytes "Draw";
             }
          else {
            const !v330 = PEQ(v55,DLC_Int 2);
            if v330 then {
              v322 = DLC_Bytes "Alice wins";
               }
            else {
              const !v331 = PEQ(v55,DLC_Int 3);
              if v331 then {
                v322 = DLC_Bytes "Alice quits";
                 }
              else {
                v322 = DLC_Bytes "Bob quits";
                 };
               };
             };
           };
        eff interact("B")."endsWith"(v322);
        
         } } },
  "O" = interact {
    };
  sendrecv join(v7) 1 ()(v5, v6){
    const !v9 = ADD(v5,v6);
    const !v10 = TXN_VALUE();
    const !v11 = PEQ(v9,v10);
    claim(CT_Require)(v11);
    sendrecv join(v15) 2 ()().timeout(DLC_Int 10, {
      sendrecv again(v7) 14 ()(){
        const !v20 = TXN_VALUE();
        const !v21 = PEQ(DLC_Int 0,v20);
        claim(CT_Require)(v21);
         } }){
      const !v16 = TXN_VALUE();
      const !v17 = PEQ(v5,v16);
      claim(CT_Require)(v17);
      sendrecv again(v7) 3 ()().timeout(DLC_Int 10, {
        sendrecv again(v15) 13 ()(){
          const !v40 = TXN_VALUE();
          const !v41 = PEQ(DLC_Int 0,v40);
          claim(CT_Require)(v41);
           } }){
        const !v36 = TXN_VALUE();
        const !v37 = PEQ(DLC_Int 0,v36);
        claim(CT_Require)(v37);
        loopvar {
          v54 = DLC_Int 0,
          v55 = DLC_Int 1};
        invariant{
          () }
        while{
          (begin const !v79 = PEQ(v55,DLC_Int 1);
           v79) }
        {
          sendrecv again(v7) 5 ()(v102).timeout(DLC_Int 10, {
            sendrecv again(v15) 12 ()(){
              const !v107 = TXN_VALUE();
              const !v108 = PEQ(DLC_Int 0,v107);
              claim(CT_Require)(v108);
               } }){
            const !v103 = TXN_VALUE();
            const !v104 = PEQ(DLC_Int 0,v103);
            claim(CT_Require)(v104);
            sendrecv again(v15) 6 ()(v139).timeout(DLC_Int 10, {
              sendrecv again(v7) 11 ()(){
                const !v144 = TXN_VALUE();
                const !v145 = PEQ(DLC_Int 0,v144);
                claim(CT_Require)(v145);
                 } }){
              const !v140 = TXN_VALUE();
              const !v141 = PEQ(DLC_Int 0,v140);
              claim(CT_Require)(v141);
              const !v159 = PLE(DLC_Int 0,v139);
              const !v160 = PLT(v139,DLC_Int 3);
              const !v162 = IF_THEN_ELSE(v159,v160,DLC_Bool False);
              claim(CT_Require)(v162);
              sendrecv again(v7) 7 ()(v173, v174).timeout(DLC_Int 10, {
                sendrecv again(v15) 10 ()(){
                  const !v179 = TXN_VALUE();
                  const !v180 = PEQ(DLC_Int 0,v179);
                  claim(CT_Require)(v180);
                   } }){
                const !v175 = TXN_VALUE();
                const !v176 = PEQ(DLC_Int 0,v175);
                claim(CT_Require)(v176);
                const !v194 = digest(v173,v174);
                const !v195 = PEQ(v102,v194);
                claim(CT_Require)(v195);
                const !v197 = PLE(DLC_Int 0,v174);
                const !v198 = PLT(v174,DLC_Int 3);
                const !v200 = IF_THEN_ELSE(v197,v198,DLC_Bool False);
                claim(CT_Require)(v200);
                let v202;
                const !v204 = PLE(DLC_Int 0,v174);
                const !v205 = PLT(v174,DLC_Int 3);
                const *v207 = IF_THEN_ELSE(v204,v205,DLC_Bool False);
                const !v209 = PLE(DLC_Int 0,v139);
                const !v210 = PLT(v139,DLC_Int 3);
                const *v212 = IF_THEN_ELSE(v209,v210,DLC_Bool False);
                const !v214 = IF_THEN_ELSE(v207,v212,DLC_Bool False);
                if v214 then {
                  const !v215 = SUB(DLC_Int 4,v139);
                  const !v216 = ADD(v174,v215);
                  const !v217 = MOD(v216,DLC_Int 3);
                  v202 = v217;
                   }
                else {
                  if v207 then {
                    v202 = DLC_Int 2;
                     }
                  else {
                    if v212 then {
                      v202 = DLC_Int 0;
                       }
                    else {
                      v202 = DLC_Int 1;
                       };
                     };
                   };
                sendrecv again(v15) 8 ()().timeout(DLC_Int 10, {
                  sendrecv again(v7) 9 ()(){
                    const !v279 = TXN_VALUE();
                    const !v280 = PEQ(DLC_Int 0,v279);
                    claim(CT_Require)(v280);
                     } }){
                  const !v275 = TXN_VALUE();
                  const !v276 = PEQ(DLC_Int 0,v275);
                  claim(CT_Require)(v276);
                  const !v293 = ADD(DLC_Int 1,v54);
                  {
                    v54 = v293,
                    v55 = v202}
                  continue; } } } } }
        let v299;
        const !v300 = PEQ(v55,DLC_Int 2);
        if v300 then {
          const !v301 = MUL(DLC_Int 2,v5);
          v299 = [v301,DLC_Int 0];
           }
        else {
          const !v302 = PEQ(v55,DLC_Int 0);
          if v302 then {
            const !v303 = MUL(DLC_Int 2,v5);
            v299 = [DLC_Int 0,v303];
             }
          else {
            v299 = [v5,v5];
             };
           };
         } } }}

{
  1 = {
    join(v7),
    (between [] []),
    last = 0,
    [],
    [v5, v6],
    {
      const !v9 = ADD(v5,v6);
      const !v10 = TXN_VALUE();
      const !v11 = PEQ(v9,v10);
      claim(CT_Require)(v11);
      (wait! [v7, v5, v6]) } },
  2 = {
    join(v15),
    (between [] [DLC_Int 10]),
    last = 1,
    [v7, v5, v6],
    [],
    {
      const !v16 = TXN_VALUE();
      const !v17 = PEQ(v5,v16);
      claim(CT_Require)(v17);
      (wait! [v7, v5, v6, v15]) } },
  3 = {
    again(v7),
    (between [] [DLC_Int 10]),
    last = 2,
    [v7, v5, v6, v15],
    [],
    {
      const !v36 = TXN_VALUE();
      const !v37 = PEQ(DLC_Int 0,v36);
      claim(CT_Require)(v37);
      (jump! 4 [v7, v5, v6, v15] {
        v54 = DLC_Int 0,
        v55 = DLC_Int 1}) } },
  4 = {
    loop!,
    [v7, v5, v6, v15],
    [v54, v55],
    {
      const !v79 = PEQ(v55,DLC_Int 1);
      
      if v79 then {
        (wait! [v7, v5, v6, v15, v54]) }
      else {
        let v299;
        const !v300 = PEQ(v55,DLC_Int 2);
        if v300 then {
          const !v301 = MUL(DLC_Int 2,v5);
          v299 = [v301,DLC_Int 0];
           }
        else {
          const !v302 = PEQ(v55,DLC_Int 0);
          if v302 then {
            const !v303 = MUL(DLC_Int 2,v5);
            v299 = [DLC_Int 0,v303];
             }
          else {
            v299 = [v5,v5];
             };
           };
        const !v304 = v299[0];
        const !v305 = v299[1];
        const !v306 = ADD(v6,v304);
        transfer.(v306).to(v7);
        transfer.(v305).to(v15);
        (halt! ) }; } },
  5 = {
    again(v7),
    (between [] [DLC_Int 10]),
    last = 4,
    [v7, v5, v6, v15, v54],
    [v102],
    {
      const !v103 = TXN_VALUE();
      const !v104 = PEQ(DLC_Int 0,v103);
      claim(CT_Require)(v104);
      (wait! [v7, v5, v6, v15, v102, v54]) } },
  6 = {
    again(v15),
    (between [] [DLC_Int 10]),
    last = 5,
    [v7, v5, v6, v15, v102, v54],
    [v139],
    {
      const !v140 = TXN_VALUE();
      const !v141 = PEQ(DLC_Int 0,v140);
      claim(CT_Require)(v141);
      const !v159 = PLE(DLC_Int 0,v139);
      const !v160 = PLT(v139,DLC_Int 3);
      const !v162 = IF_THEN_ELSE(v159,v160,DLC_Bool False);
      claim(CT_Require)(v162);
      (wait! [v7, v5, v6, v15, v102, v139, v54]) } },
  7 = {
    again(v7),
    (between [] [DLC_Int 10]),
    last = 6,
    [v7, v5, v6, v15, v102, v139, v54],
    [v173, v174],
    {
      const !v175 = TXN_VALUE();
      const !v176 = PEQ(DLC_Int 0,v175);
      claim(CT_Require)(v176);
      const !v194 = digest(v173,v174);
      const !v195 = PEQ(v102,v194);
      claim(CT_Require)(v195);
      const !v197 = PLE(DLC_Int 0,v174);
      const !v198 = PLT(v174,DLC_Int 3);
      const !v200 = IF_THEN_ELSE(v197,v198,DLC_Bool False);
      claim(CT_Require)(v200);
      let v202;
      const !v204 = PLE(DLC_Int 0,v174);
      const !v205 = PLT(v174,DLC_Int 3);
      const *v207 = IF_THEN_ELSE(v204,v205,DLC_Bool False);
      const !v209 = PLE(DLC_Int 0,v139);
      const !v210 = PLT(v139,DLC_Int 3);
      const *v212 = IF_THEN_ELSE(v209,v210,DLC_Bool False);
      const !v214 = IF_THEN_ELSE(v207,v212,DLC_Bool False);
      if v214 then {
        const !v215 = SUB(DLC_Int 4,v139);
        const !v216 = ADD(v174,v215);
        const !v217 = MOD(v216,DLC_Int 3);
        v202 = v217;
         }
      else {
        if v207 then {
          v202 = DLC_Int 2;
           }
        else {
          if v212 then {
            v202 = DLC_Int 0;
             }
          else {
            v202 = DLC_Int 1;
             };
           };
         };
      (wait! [v202, v7, v5, v6, v15, v54]) } },
  8 = {
    again(v15),
    (between [] [DLC_Int 10]),
    last = 7,
    [v202, v7, v5, v6, v15, v54],
    [],
    {
      const !v275 = TXN_VALUE();
      const !v276 = PEQ(DLC_Int 0,v275);
      claim(CT_Require)(v276);
      const !v293 = ADD(DLC_Int 1,v54);
      (jump! 4 [v7, v5, v6, v15] {
        v54 = v293,
        v55 = v202}) } },
  9 = {
    again(v7),
    (between [DLC_Int 10] []),
    last = 7,
    [v202, v7, v5, v6, v15, v54],
    [],
    {
      const !v279 = TXN_VALUE();
      const !v280 = PEQ(DLC_Int 0,v279);
      claim(CT_Require)(v280);
      const !v281 = BALANCE();
      transfer.(v281).to(v7);
      (halt! ) } },
  10 = {
    again(v15),
    (between [DLC_Int 10] []),
    last = 6,
    [v7, v5, v6, v15, v102, v139, v54],
    [],
    {
      const !v179 = TXN_VALUE();
      const !v180 = PEQ(DLC_Int 0,v179);
      claim(CT_Require)(v180);
      const !v181 = BALANCE();
      transfer.(v181).to(v15);
      (halt! ) } },
  11 = {
    again(v7),
    (between [DLC_Int 10] []),
    last = 5,
    [v7, v5, v6, v15, v102, v54],
    [],
    {
      const !v144 = TXN_VALUE();
      const !v145 = PEQ(DLC_Int 0,v144);
      claim(CT_Require)(v145);
      const !v146 = BALANCE();
      transfer.(v146).to(v7);
      (halt! ) } },
  12 = {
    again(v15),
    (between [DLC_Int 10] []),
    last = 4,
    [v7, v5, v6, v15, v54],
    [],
    {
      const !v107 = TXN_VALUE();
      const !v108 = PEQ(DLC_Int 0,v107);
      claim(CT_Require)(v108);
      const !v109 = BALANCE();
      transfer.(v109).to(v15);
      (halt! ) } },
  13 = {
    again(v15),
    (between [DLC_Int 10] []),
    last = 2,
    [v7, v5, v6, v15],
    [],
    {
      const !v40 = TXN_VALUE();
      const !v41 = PEQ(DLC_Int 0,v40);
      claim(CT_Require)(v41);
      const !v42 = BALANCE();
      transfer.(v42).to(v15);
      (halt! ) } },
  14 = {
    again(v7),
    (between [DLC_Int 10] []),
    last = 1,
    [v7, v5, v6],
    [],
    {
      const !v20 = TXN_VALUE();
      const !v21 = PEQ(DLC_Int 0,v20);
      claim(CT_Require)(v21);
      const !v22 = BALANCE();
      transfer.(v22).to(v7);
      (halt! ) } }}