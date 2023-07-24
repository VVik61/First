  3: writeln(tfOut, DM_S.TmpDSQL[22]+sTekReg+''', 0, 1, date ''00.00.2023'', date ''00.00.2023'');  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
     //Антибиотики:  22 INSERT INTO S_LEC_ABC (CODLEC_ABC, R_LEC_ABC, IDANTIB, IDANTIB_VVED, DATA_N, DATA_Z) VALUES (gen_id(GEN_ANBIOT_L, 1), '
        //INSERT INTO S_LEC_ABC (CODLEC_ABC, R_LEC_ABC, IDANTIB, IDANTIB_VVED, DATA_N, DATA_Z) VALUES (gen_id(GEN_ANBIOT_L, 1), 'P202300058',
        //168, 1, date '29.05.2023', date '04.06.2023');

  6: ; //Антидотная терапия:
  7: ; //Антиконвульсанты:                                                    
  9: ; //Антиферментные препараты:                                            
 11: ; //Корректоры нейролептической терапии:                                 
 17: ; //Гепарин:                                                             
 18: writeln(tfOut, DM_S.TmpDSQL[28]+sTekReg+''',  1);  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
     //Гепатотропные препараты: 28=INSERT INTO S_HEPATOTROP (CODHEPATOTROP, R_HEPATOTROP, IDHEPATOTROP) VALUES (gen_id(GEN_HEPATO_L,1), '
 19: writeln(tfOut, DM_S.TmpDSQL[16]+sTekReg+''',  1);  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
     //Дезинтоксикация медикаментозная: 16 INSERT INTO S_DETOXICA (CODDETOXICA, R_DETOXICA, IDDETOXICA) VALUES (gen_id(GEN_DETOX_L,1), 'P202300058', 1);
 21: writeln(tfOut, DM_S.TmpDSQL[24]+sTekReg+''',  1);  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
     //Диуретики: 24=INSERT INTO S_DIURETIK (CODDIURETIK, R_DIURETIK, IDDIURETIK) VALUES (gen_id(GEN_DIURET_L, 1), '
 23: writeln(tfOut, DM_S.TmpDSQL[17]+sTekReg+''',  1);  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
     //Кортикостероиды: 17=INSERT INTO S_GORMON (CODGORMON, R_GORMON, IDGORMON) VALUES (gen_id(GEN_GORMON_L, 1), '
 25: writeln(tfOut, DM_S.TmpDSQL[18]+sTekReg+''',  1);  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
     //Коррекция гемодинамики: 18=INSERT INTO S_HEMODINAM (CODHEMODINAM, R_HEMODINAM, IDHEMODINAM) VALUES (gen_id(GEN_HEMODIN_L, 1), '

 27: ; //Коррекция свертываемости крови:
 29: ; //Миорелаксанты:                                                       
 31: writeln(tfOut, DM_S.TmpDSQL[29]+sTekReg+''', 0, NULL);  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
     //Нейролептики: 29=INSERT INTO S_PSIXTROP(CODPSIXTROP, R_PSIXTROP, IDPSIXTROP, PSIXTROP_PRIM) VALUES (gen_id(GEN_PSI_L, 1), '
     //INSERT INTO S_PSIXTROP(CODPSIXTROP, R_PSIXTROP, IDPSIXTROP, PSIXTROP_PRIM) VALUES (gen_id(GEN_PSI_L, 1),  '
     //P202300009', 9, '12 мг/сутки 01.01-06.01.23г.(в о.психиатрическом отделении) ');
34: writeln(tfOut, DM_S.TmpDSQL[19]+sTekReg+''',  1);  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
     //Ноотропы: 19=INSERT INTO S_NOOTROP (CODNOOTROP, R_NOOTROP, IDNOOTROP) VALUES (gen_id(GEN_NOOTR_L, 1), '
 38: writeln(tfOut, DM_S.TmpDSQL[27]+sTekReg+''',  1);  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
     //Профилактика дисбактериоза:27=INSERT INTO S_DISBAKTERY(CODDISBAKTERY, R_DISBAKTERY, IDDISBAKTERY) VALUES (gen_id(GEN_DISBAKT_L, 1), '
 39: writeln(tfOut, DM_S.TmpDSQL[25]+sTekReg+''',  1);  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
     //Психотропные средства (в остром периоде психоза): 25=INSERT INTO S_PSIXTROP_OP (CODPSIXTROP_OP, R_PSIXTROP_OP, IDPSIXTROP_OP) VALUES (gen_id(GEN_PSI_OP_L, 1), '
 45: ; //Сульфаниламиды:
 47: writeln(tfOut, DM_S.TmpDSQL[20]+sTekReg+''',  1);  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
     //Церебральные вазопротекторы: 20=INSERT INTO S_CERPROTEKT(codcerprotekt, r_cerprotekt, idcerprotekt) VALUES (gen_id(GEN_CEREBRO_L, 1), '

 49: ; //Противогрибковые препараты:
 50: writeln(tfOut, DM_S.TmpDSQL[26]+sTekReg+''',  1);  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
   //Коррекция аффективных и поведенческих расстройств: 26=INSERT INTO S_POVEDENIE (CODPOVEDENIE, R_POVEDENIE, IDPOVEDENIE) VALUES (gen_id(GEN_KOR_POV_L, 1), '
 51: ; //Аэрозольные ингаляции:
 53: ; //ИВЛ (длительная):
 54: ; //Интубация трахеи термопластической трубкой:                          
 56: ; //Питание:                                                             
 57: writeln(tfOut, DM_S.TmpDSQL[23]+sTekReg+''', date ''00.00.2023'', date ''00.00.2023'', NULL);  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
     //Катетеризация мочевого пузыря:  23=INSERT INTO S_URKAT_L (CODURKAT_L, R_URKAT_L, DATA_UKAT_N, DATA_UKAT_Z, URKAT_L_PRIM)  VALUES ( gen_id(GEN_URETR_KAT_L, 1), '
     //INSERT INTO S_URKAT_L (CODURKAT_L, R_URKAT_L, DATA_UKAT_N, DATA_UKAT_Z, URKAT_L_PRIM)  VALUES ( gen_id(GEN_URETR_KAT_L, 1), 'P202300057
     //',   date '26.05.2023', date '04.06.2023', NULL);
 59: ; //Лазерное облучение повреждений кожи лазером:                         
 63: writeln(tfOut, DM_S.TmpDSQL[20]+sTekReg+''',  1);  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
     //Меcтное лечение: 21=INSERT INTO S_MESTNOE(CODMESTNOE, R_MESTNOE, IDMESTNOE) VALUES (gen_id(GEN_MESTNO_L,1), '
 72: ; //Переливание препаратов крови:                                        
 75: ; //Реанимационные мероприятия:                                          
 78: ; //Энтеросорбция:                                                       
 79: ; //ЭСТ:                                                                 
 80: ; //Форсированная инсулино-коматозная терапия (ФИКТ):                    
 82: ; //Гемосорбция экстракорпоральная:                                      
 83: ; //Иммобилизация конечности:                                            
 84: ; //Катетеризация центральных сосудов:                                   
 85: ; //ЛОК:                                                                 
 86: ; //Люмбальная пункция                                                   
 87: ; //Хирургическое лечение (операции):                                    
 88: ; //Трахеостомия с установкой термопластической трахеостомической трубки:
 89: ; //УФОК:                                                                
 90: ; //Плазмаферез лечебный:                                                
 91: ; //Гипнотики:                                                           
 92: ; //Антидиабетические препараты:                                         
 93: writeln(tfOut, DM_S.TmpDSQL[35]+sTekReg+''', 0, NULL);  --'+IBDS_RAB.FieldByName('rubrlec').AsString);
     //Антидепрессанты: 35=INSERT INTO S_ANTIDEPRES(CODANTIDEPRES, R_ANTIDEPRES, IDANTIDEPRES, ANTIDEPRES_PRIM) VALUES (gen_id(GEN_AN_DEPRES_L, 1), '
     //INSERT INTO S_ANTIDEPRES(CODANTIDEPRES, R_ANTIDEPRES, IDANTIDEPRES, ANTIDEPRES_PRIM) VALUES (gen_id(GEN_AN_DEPRES_L, 1), '
     //P199400153', 8, '1-кратно'); --P199400153  Антидепрессанты (лудиомил - 1-кратно).
 94: ; //Антипаркинсоническая терапия:                                        
100: ; //Лекарство или тип лечения, которого нет в списке:                    
