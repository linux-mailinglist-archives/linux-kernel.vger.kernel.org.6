Return-Path: <linux-kernel+bounces-426570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F07769DF513
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 10:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B839B281192
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 09:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7723984D13;
	Sun,  1 Dec 2024 09:11:07 +0000 (UTC)
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazon11020129.outbound.protection.outlook.com [52.101.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3D6A332;
	Sun,  1 Dec 2024 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.227.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733044266; cv=fail; b=U87wGZvHJjQg0zwK7NhWPt1nILxjqwU+7vQOBLTIbkjtpaO3JsIt1nhe8mte5ZjOl6phYamW3ufXR39RgAS+lJhU4qj2mEMmTIwx1+FXvTyoEVd+cGOkg5VT+q+eVDy/bgZRSE2lSiRTFRWbtYWqiibFzflD3KqaJ1fmPOxeEMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733044266; c=relaxed/simple;
	bh=8flKPuUmm2FovxGZft8JhM8kWwIkB8t9TEV7/FXgHTc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bgLfgVKzxGPiVRAMV1fMUQLBYDMZAPb0Fn7UI1tHS39mGdZyX15gCyVIAq7Awq8EI0l7WOt+IZKxp9sr3mR06rr+56KdAzEZaOeVU9MTeNERHitNj/rC45Fz/xBe2xTtasUJfx++wUKIb8dXjKSQA8wDDTjKVJu67ZKVLdlu8z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=none smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=52.101.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=siliconsignals.io
Received: from PN1P287MB3616.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:253::13)
 by PN2P287MB1630.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Sun, 1 Dec
 2024 07:36:40 +0000
Received: from PN0P287MB1096.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:142::9)
 by PN1P287MB3616.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:253::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Sun, 1 Dec
 2024 04:13:24 +0000
Received: from MA0P287MB0434.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:c9::13)
 by PN0P287MB1096.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:142::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.16; Sat, 30 Nov
 2024 17:03:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uFFrCd5leb/e30VL2Y6n1GIQnlUFmvxtBOLG6Xyb5qoygVB0Y9zSk97sHdZTRtcwhks+b+N6s7XSljQdHDL3/cdxQjH0rXueBB4fkyOYtUho584F+lzjP2TzIodRYBjcFE7eRCYNjntX8qld160hjswVZUpb9/zkxJ2/jjxNEWKjrwv+kbKD5CMhjvvAJNyM9XK5jfrQiK7YQUkMjeQhQ+YM8FOe9bvYpHN565FbA6KlH7nXVMkC0weq+s2Trjker26X0QhdIKjfIXEb9OBKqDFhRlnAuweaVBMCqkG3hcnq/xzYLKKUR03L4kryvJoJlooG/KPhtR3cdXfueJaXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWzgapb4N/L9KdbSBx/D4uImnUqmagJQKm605vEi29o=;
 b=yyYTApXcHMc6zi0ojDnX/mCw0QWqXDIbJ8VWzE63xfNKAPT/psteymciPOiW3W/hf2sX0Jto+3GP7R9tTr63ixtyHg6eQvQkaALzBPIOXWmx5pAs+Ri7i9G+wAEp3MpgosCtIILJRVJqUvGDo771BxkL/hneg8s2R9Qp1E8bhJVyproqWCgaECpH5SmgJppGnk41JnpOXSo0FsHuwgE8yJJuuzXWmkge/p6sVwqCm5QMAUuoDoh33nEShdVVYpp53quJArDUimhVDVV1Za2BQIDR1DrgDWc/0UWmkKHyZVcPD/cdD4znQKiNVNHr6P2sPmFHGB+bmGliqAJpxY7SEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:fc::7) by
 MA0P287MB0434.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:c9::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.16; Sat, 30 Nov 2024 09:46:00 +0000
Received: from MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2]) by MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 ([fe80::56b4:3b88:bcc8:b1c2%7]) with mapi id 15.20.8207.014; Sat, 30 Nov 2024
 09:45:59 +0000
From: Bhavin Sharma <bhavin.sharma@siliconsignals.io>
To: krzk+dt@kernel.org,
	sre@kernel.org
Cc: Bhavin Sharma <bhavin.sharma@siliconsignals.io>,
	Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] power: supply: Add STC3117 Fuel Gauge
Date: Sat, 30 Nov 2024 15:14:17 +0530
Message-ID: <20241130094531.14885-1-bhavin.sharma@siliconsignals.io>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0165.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::9) To MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:fc::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	MA0P287MB1178:EE_|MA0P287MB0434:EE_|PN0P287MB1096:EE_|PN1P287MB3616:EE_|PN2P287MB1630:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8e4acc-eaed-475b-e92a-08dd1123cbb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?FHTWvdK1Y48s6tCogI4RT20mIHFBa4zLdaBG1IIRuovkGu+noHLHnbzESfsL?=
 =?us-ascii?Q?0e76h7uv8aVP4XQnC2WAgyXqlMX8YzomomzV1knhYn3xdCa8WDvlP3Fn44eS?=
 =?us-ascii?Q?G4I3otxcyxENAYs6d8pIHjSavpsWwIN187FEZyJCpMa775zeJqv3owN5toeO?=
 =?us-ascii?Q?A1/wmhLeZEWHw0WgFT7aM6Wq5LkfcMw1BfUobijdVzBOs2Jo78x5vq6/iRbE?=
 =?us-ascii?Q?TEhp9XM7aQSqXH224fL/8oekuabsg8HT09pg2dGxp7I2nxq/GhY4R7QoZYG5?=
 =?us-ascii?Q?RM9elSZHQwvFH3CJFHdjnjZ/GpRwHBS5M4FsWXjMHadt/hC3LpaSrZOj3z4D?=
 =?us-ascii?Q?hvyWfqJcsSo8GeYQk5tGxwaCsb3lcGRIGj0mTeevFYAK6C50zn8a3Mic6pLk?=
 =?us-ascii?Q?pPq8pb+TuqUDTAHs6fABF7FMhPyJ8FfvwyuCiTkK0vRP2orIqyWYfDvFPNB7?=
 =?us-ascii?Q?Trbh44pEpNIzn/lLOe85tD14jx/LwW0NJib5JVLrIjmVg3jEcKnBJ02tWsqm?=
 =?us-ascii?Q?z+bbvYKMhECdNm2L/Mz8Xcss7UMgR7DmXuUWBiNQsuiPq1Kp+vEIpJguX1Hh?=
 =?us-ascii?Q?ZkZMk7lMH6USKW9eUDyPNwRkLAOV5JOBxMR1MYVJtHXP8q4aV8Aq4TkdRlps?=
 =?us-ascii?Q?i3MCLfEUWgYaDkGYjtgAftjq1gxVz9bA4yW2SQVrX5uXjx9vPRCVD3x/fywy?=
 =?us-ascii?Q?/6D9haKhMeZ6bRN+kHErsOPWI8NghwQCr5OGUmOm69pohCPxNgs4FjHReQCn?=
 =?us-ascii?Q?5j2Skvbdq5G43KSYvYX6p77kQZWhm8iRnIQ8YlGfjv8iL6+Kp3o63r7LqriM?=
 =?us-ascii?Q?LTCVU0htU0Lt+xE29XdqkK7cGQ3H4eqFe7XD0/IAarEyNSKqYMROLIYSkNKa?=
 =?us-ascii?Q?NAPXe0aPbfshewLGyjvRE7DTvnb1crP4iM+7KPWTysWI2ZZ+StXZ7F7sGHxA?=
 =?us-ascii?Q?RyRnZdqXAbl9+cfbKO2cMW4Br85ZLUaG7V9QABmYq5WLdwYKKaAz2dlyN2d/?=
 =?us-ascii?Q?DWP5FTci7tO4K3zJv+GFt+a2SnoT1xr3uD8z5GIfsl1ZamNCKtyoZ+dJyD0C?=
 =?us-ascii?Q?GHsGU4folGyuoDVaF3p+YQB3k1zmgU/vApEnq4IrsCTwG6v8DBaNU3TVDHy5?=
 =?us-ascii?Q?ERwKTFZ/WrnXPvAg/U2e8y0860tsRWaPiHJeizfnanTGNdQ0EfF5kJ5Fm4Cv?=
 =?us-ascii?Q?lGZ+2BLT0QNZHIVayAC3axRHHd5XMIlbVBwKTeWkNxBNZQvsDQVlxohZVjsi?=
 =?us-ascii?Q?AiCSREhfq1/lrFNwy+Z9XInluDl5gPVebTiRwNStHmj2+1Mo4gVEN7YGpEnX?=
 =?us-ascii?Q?weJspo2+PacmcvtEeLZHaDpBV+qaky7SFXEve2pUoK7oNVtmX1J7lwalniCI?=
 =?us-ascii?Q?6o5Q3Kw=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MA0P287MB1178.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?5/Rjc0HVr6QjGmEX/oUPIm7tfrd28skeyBOVBZjhqxW2FkVKcTRRBAef9ayi?=
 =?us-ascii?Q?iZZcEAU8xh0plQAROZPOf89hg/oc1x2xDW1TABkUopvxVNfXKNzeb2Jwa0L/?=
 =?us-ascii?Q?DswXSFv7tbpzPgZOkW3rTdas2yzjseGWRpPDTpx3M4PKGiq2izPh5Lv89/0Z?=
 =?us-ascii?Q?/GY7WpoimoZI7/MeePld8Q06kMmjnFTea8rifhzFDcT6ug213MIpRhC9Gquf?=
 =?us-ascii?Q?D3CkPBAc4hhAJj9BOxH2Cdo+lUksec0QWiEOYUI8QFgUIkZBXVWcnXaSvSVb?=
 =?us-ascii?Q?hAACWtsD45ZVEDP3zlcAlPB4xp69zbXh9sw5vuHOgKrv3N7wAipIUUlQbq/N?=
 =?us-ascii?Q?OhkK2oRmnR2QKm9rLyEw7/5oY1BDUvL0XWC/8MKUExhXBjbh4ui9FI6SDSMX?=
 =?us-ascii?Q?2ekiR0pml+OGuY9HVoM4PdaLc7lBn2O8cYY8oGQAP8uXX8Dz4QN56Qx+qPuM?=
 =?us-ascii?Q?wMORIPqi+6sQ4ShxY54hcsjRZtT5w/n/pQzhQhu9hvm5DKPb7ucCdbR1pTuC?=
 =?us-ascii?Q?yVv/vibJMPBpROCT3zca1Qunklan3RAe294TXRt9MwLQQEPtAUG03sZHTdhx?=
 =?us-ascii?Q?COeA7HfT3r9c1WtP1XmHfODlhl/hN+KKG8/3R6XEABYefHg9V2z6zrw7+z6f?=
 =?us-ascii?Q?vAdQlQqp232ybx/qZekvXj7r7FwN6ySu8CCcXie3unxYsE2dz55csKNyujO3?=
 =?us-ascii?Q?83uPNg3RmxWWWBbD8tloY3hP9arHCja9wuKfFqYTyETG5XzegE5+46Pri6J6?=
 =?us-ascii?Q?Stp5bm7z9t/QbXUo0Y+Rl16cBJz9dIqVJAPsfnp20tk2I3Ma4I/sZvksGEi7?=
 =?us-ascii?Q?PMqqR8W0Y1pzUfZKdSMYk12gs27zLkRw5VYcu0Nsvd/+PSERMKvP9EmSx+Kl?=
 =?us-ascii?Q?wWD+6Q8td9htL/kEjkUs3LlprO/mhDAasNns4ZYA1+STAtRvj2pI8OvUqziR?=
 =?us-ascii?Q?BYN6BrLg4WldMDm8Bio54CL8o15o5MsQHMEaBYZZi4flwix2I26IYmoloTMO?=
 =?us-ascii?Q?i1RPZfZt9hI89Hzfhas3nCjJ/OiiOaqJhF97RzGIleC1MpPW8TVTinYI89KX?=
 =?us-ascii?Q?k+Sj30W/yiQJKAWfY7XAeA2YDU4/UAlIh18NJQAicQmiQTDHjT5P9vDIhySJ?=
 =?us-ascii?Q?wpZYq7AS+E8iHK0dK3/NFZBnawaS/LNyDzuFs1Z8BTCdrtFY+nnceh/GjOr5?=
 =?us-ascii?Q?R1XpMRFkdxtQBGBvce9zay4qSgVHZ98KRGpR81QCd0cDb/ewNCIiSV61TUCm?=
 =?us-ascii?Q?agdZ2K8VOv5RuFJG1hOp5Mon7M4alM3ZCswOBwcCapIwRQpXtHp8joBOTemZ?=
 =?us-ascii?Q?5p0f+dcCTbp/UKo4mg11MEnvEt9Vfwa5bgx8GdS8dSc84QgHrB6X9k0W4RSG?=
 =?us-ascii?Q?P2HTTqpT4ZPXop737RzkKtahRzC4VFSyyh/Tt/J5PXc4KDkC3FwGEtiCmnLj?=
 =?us-ascii?Q?SBmyn6abd5XBzGuepWY/RaVo45k1uPXwbZmYT/uwBubCPjs7gVsjBHBhq5TM?=
 =?us-ascii?Q?a2mG1Z8TlWIr+8gTk/BmE4Asb+E3c7VkGSw6NW0sEOrJYeY9aPQrF6WF1GQt?=
 =?us-ascii?Q?d8JMXwwYKh9b4QnU9ru1Nh88NI9Pn9Pp+0M1j63c6fgXx+0PevTyGETheowZ?=
 =?us-ascii?Q?F65BSNRZbQFt/UPxHVQbzZw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8e4acc-eaed-475b-e92a-08dd1123cbb8
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB1178.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2024 09:45:59.7573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aIFk7WvZI4BFligqL6GnliLqlMQ2CSJ6Q2BAPqTe+ofmovRu/1zzXpeedDcyaiJRuDLhqCSDdSJbxZzMMKAtJoIZUpMDBTUrvmXWhA7QPx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB0434
X-OriginatorOrg: siliconsignals.io

Adds initial support for the STC3117 fuel gauge.                                

v5 -> v6

- Use shunt-resistor-micro-ohms property instead of sense-resistor.
- Remove the battery node from the binding examples.
- Add interrupt bindings to the example.
- Correct the Signed-off-by (SoB) order in the commit.

Link for v5: https://lore.kernel.org/linux-pm/20241129114200.13351-1-bhavin.sharma@siliconsignals.io/T/#t 
                                                                                
v4 -> v5                                                                        
                                                                                
- Fix variable names                                                            
- Limit code line length to 80 columns                                          
- Add interrupt and monitor-battery properties to bindings                      
- Correct error handling with return dev_err_probe()                            
                                                                                
Link for v4: https://lore.kernel.org/linux-pm/21c08a45-34f1-443c-97d4-6baf9fa01b67@kernel.org/T/#t
                                                                                
v3 -> v4                                                                        
                                                                                
- Added support for current, soc, temp, and status properties.                  
- Addressed comments and feedback provided by Krzysztof and Sebastian.          
                                                                                
Link for v3: https://lore.kernel.org/linux-pm/20240205051321.4079933-1-bhavin.sharma@siliconsignals.io/T/#t
                                                                                
v2 -> v3                                                                        
                                                                                
- Resolved DTC warnings and errors                                              
- Formatted the changelogs                                                      
- Added monitored battery properties                                            
- Replaced 'additionalProperties' with 'unevaluatedProperties'                  
- Replaced '&i2c6' with 'i2c'                                                   
                                                                                
Link for v2: https://lore.kernel.org/linux-pm/202401080530.0hMWnrIg-lkp@intel.com/T/#t
                                                                                
v1 -> v2                                                                        
                                                                                
- String value is redundantly quoted with any quotes (quoted-strings)           
- Found character '\t' that cannot start any token                              
                                                                                
Link for v1: https://lore.kernel.org/linux-pm/46bba29c-330d-417d-ad84-ceb5207fdb55@wanadoo.fr/T/#t
                                                                                
Hardevsinh Palaniya(1):                                                         
  dt-bindings: power: supply: Add STC3117 Fuel Gauge                            

Bhavin Sharma (2):
  power: supply: Add STC3117 fuel gauge unit driver

 .../bindings/power/supply/st,stc3117.yaml     |  74 ++
 MAINTAINERS                                   |   8 +
 drivers/power/supply/Kconfig                  |   7 +
 drivers/power/supply/Makefile                 |   1 +
 drivers/power/supply/stc3117_fuel_gauge.c     | 666 ++++++++++++++++++
 5 files changed, 756 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/st,stc3117.yaml
 create mode 100644 drivers/power/supply/stc3117_fuel_gauge.c

-- 
2.43.0


