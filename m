Return-Path: <linux-kernel+bounces-191570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABF98D1102
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003B32814FB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A6174405;
	Tue, 28 May 2024 00:37:04 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F6371B39
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856623; cv=fail; b=INM92nv9gLrgxuayid/8hDCvJnZJPFMGs8ZHg0s/bX3+TJs8mXJSJ3hzzXlC/Lwls8HoQcOTslbYwOtVKdnqy/tp72/KsWVAv4aMrbU8DqAV+m1/WQ8bXfia0Rt6K/w2NZ7K/Da7LkmnFeQo1/dCTWTPMlgDKTAlpL4d6+LsOxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856623; c=relaxed/simple;
	bh=AcC8fGzlvQY6Q7bPIiUxuvQ41GOudI/fXim5Pwc+Smc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQNZwGiNCsEvlrSv4F5s0bjiWn5tIpFKlH1JsVPYMUEKJkAEVbjvke65xou0M/1HNgjByq1mLV0ELdNz6/N8tiYRkPssWyS1GQPwAA+v49llcTp8AiCouJKYbSCXHnQDfWP7hvVrw584AV6t/uN5B9Hgabwq6A0zyxJ7XFf9WxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDI4lW025171;
	Tue, 28 May 2024 00:36:43 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DnL3tPWurbDorWycx6Qrw09g4tdHQRh5vOFmLrfEeXpE=3D;_b?=
 =?UTF-8?Q?=3DQKxx8FDTZsQOpF62ii7OHlfDpHzsX2bQotc1xmAGeIDGTVpax3dQY6UugroI?=
 =?UTF-8?Q?k+OITIka_Djqgwf6hzrbV9Qh6wIZM+g6u8INgL+CJgWbzSLrQKihGBItFXEGUir?=
 =?UTF-8?Q?WwEwk4GsmPfiGg_0eT5ofsfZFUyT7oFHyoi7ARUEw1zXUsrA6n/KniYCmd1Axgu?=
 =?UTF-8?Q?/NaO/SzARIPby7qnc4/A_P0Vu/QvokZApByJfks46K9oTCrxz8qME0xCwrkubr+?=
 =?UTF-8?Q?XfjkJxTM/n0hlT4TVRJflvNK45_BceA/AsGxkjnj80Fa5n7CeOfeqeH7+VqITR5?=
 =?UTF-8?Q?F0eoq1/u6V/uvXjpGCiUJ/uZvAhVBFLV_XQ=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg39ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RLwloh025981;
	Tue, 28 May 2024 00:36:42 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50p7xxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlCCFl9cePigsxR71zUjsw3ZuWb/gGnF4tFssBT0eF3r037CArPUBAuJCW2hDz+0f0vHMRc1gwV1ZRckvAOxfWFQLZoFMDYxPD1VWvIpKdZkBRmxN+rK75icaFlG3kz5rKuKGD5XBXPrFlrO7JMP2crIbbNfkdXX5XDxSrgv5FdIdsYyBKw91mb7A0k26DTEKPZViocTgwYvwHZudGrMt8qSCyt1PWJ4aBUbN9eZfP7y6thxh7+Mh7pVyG00UIG8nomtwd+JPmLw+SpZ19t9gTvdLcT8orzfQ4IdePbtpNzNwKuMZKoB67ntyVdWrkWua5ZVKPQrii7jgDM58FG1sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nL3tPWurbDorWycx6Qrw09g4tdHQRh5vOFmLrfEeXpE=;
 b=aYA2+enFyRTCiI61UKPY3x1gxu1BeJbP886d42nh4FDoPqLcL/kutX/hKNKTwpqyPF76oUfE9zEMtB5UZBJ7t5i1hzI1zRXBkG3gjgFWqx8gvTeFqWcMdZGqT12dnRfsQeRkt69NMZ5Iv0CtFR7bCMepNfe2citausLuv19LVkKDIurspjKP33INJMoCcd3y4XZiCqumEmBXWrVnC9UsTLpdL0jCsY9R8S+Oy2pcIJ8eZtElx6euieNiHcU911qFLmBNRGEBBmyctmAmhlKYxq4O7Ocz7eu8B6j5p5y6cQ4MZt4dcZJmpMGFm+M0BPoBa1JkFsspABPHpULcG2aNEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nL3tPWurbDorWycx6Qrw09g4tdHQRh5vOFmLrfEeXpE=;
 b=Chb4gaKCvIW7IXFk36x+ai9kLw7wOx/FzVnLcKdQ5Alht9M7HTDz+4WoCZnWEx9ZByioMkcMk8JsD+BhvFmHi+sL09cBNjyEoTErFhV64NcCRCe5A4hCqGOpBgd/pQy8Cv1GYhyOHc51/8OG4pCaAqEwvIiW7Uo2SXoyT0vUlsM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:40 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:40 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 25/35] sched/fair: refactor update_curr(), entity_tick()
Date: Mon, 27 May 2024 17:35:11 -0700
Message-Id: <20240528003521.979836-26-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:303:2b::29) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: c0fbf81a-861d-424c-0551-08dc7eae3db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yPCSd7OXKuGXyWAVpCU3/40hVVy0tmjBawbo0l9kh75Z+Alrp0f77mo4Sd+h?=
 =?us-ascii?Q?AeYXhx6yH3CE746hR8hv8aH6RwPksLicTeFHiFAiRCbQNIbi+ViiKVbZJ1Xd?=
 =?us-ascii?Q?wtZyVmWSrGc6rXfGfo7tK6yJ8uJ9U/RI6zJihqrsyDDM8152bSv8qfdcLDC7?=
 =?us-ascii?Q?f0ggqOlwU2HcsL+AIhCrXFtsacEWCRGObjy6k4jZW+7WDTlkBFLuH3JXfssD?=
 =?us-ascii?Q?VL2cw/Tig7XQRXQMKE5BGVqm3uPg9aN/cK3x+oajN9tundadTD9a91jxNNhW?=
 =?us-ascii?Q?KNORtkqJFE9YKZr0XaQivhD7P2sTSl3Wp77Zsxi9wgELqc9KHOQtUfhokmuO?=
 =?us-ascii?Q?KVcuA2czWCIpl87OANUuLZxrdoBIPBrVSptL4iFlcaCpJMoMyyzduJLztiAi?=
 =?us-ascii?Q?gjMVwmJIA7SDZw0awvFozXTav0PnTOA19UF72dzi2a/u9rYqPh4ozC2wvZ+8?=
 =?us-ascii?Q?UVM/JI+8vqa0RpVcCi9mQgT+ZqD+Powrs6zZDzrY5xCDyBNJ+DeY5tGhS9A4?=
 =?us-ascii?Q?H0Ls+1ezZ4Alx8T0JGHeWneaS1+lHVBE+1mM3dNt9Sa0wBNp4wfdVvYiu759?=
 =?us-ascii?Q?LGQUOPbAFs8GCTI8F2W3GkQm5g1X9JFBX1AjG3JDDykShEi6BUoqn7U9eGRY?=
 =?us-ascii?Q?qhMh0eot/3bgk8eQ9GFZV3OFRdMnULjQDv8E+0Q1PZJCC9VotZorThXYXsaY?=
 =?us-ascii?Q?F5ZWGWt6SyZZoIENBTA0JIm+23B0E8noXid1JTsrdtcX3BWbldwO/W4TBcNt?=
 =?us-ascii?Q?DBTekDLY/hqG0bjI1lHjEuCfEINlypHo6z3Gb1QEU3hf+RK+4jkKGWiA8YmP?=
 =?us-ascii?Q?a9HzDbJgSpIBieJ6Ro2JrnD35lC/mPhlC7CnnxV5rylbyKf48N1vQMjd2BlU?=
 =?us-ascii?Q?VT63NseGNw0wl6jVlPvi9rcU++K1BqD0NbGM9lY87jE9JBLl0MlvP7aZXfVA?=
 =?us-ascii?Q?hykmxh8r07XL6Zp10Lk6/TtwuujJK8xwGZirPHDNzlVQOB4Tqys5z/MSqiDN?=
 =?us-ascii?Q?iB9fPiOXtOoD7795LhuhbanfIjtsiLJ22bQFgL0GI6obi91EpLfcvkAp3Jvg?=
 =?us-ascii?Q?HcKzBXwprAS1F3W0+JR150S+rhTsjTUk2BJfiBjEpPVOSpuorPorfNM+fZH2?=
 =?us-ascii?Q?9+VZ4TKsuJxFCwiIuK2ZbbPqgvfKy/Tmf7MX4Hm4YdCTKPBLgCewj+wdGGT5?=
 =?us-ascii?Q?GkP7YmvzOzSzDqk9hXkRPhEj9kyAXVuRHg9+oec51WRC41HotLqSiqV8nFq9?=
 =?us-ascii?Q?ZIzXcOtximp1c5XWwAH5xT/HC9G/q8ZjLdkHWkZVgw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bUbi0S3peedFKMtk2SQkLcMPv+NuItkicJg2hJU39gWhXaO70uKvBA3xovgf?=
 =?us-ascii?Q?6F3DrspFmr351CnbDCtIP7bwGIIFr0M1kfM2qy9ijv+0kkB2HqBLy1cL7cqs?=
 =?us-ascii?Q?kVto3BrUw3+YU0l4byDwKEne2c3bDDljyNH87g2Fo3m9hFSoRFDNCGDmOR7z?=
 =?us-ascii?Q?4WsH9gHxHzpiepDsGQi5TNXJYgwSKbQhXSIZr08cl3NBx095WAdvpS1zfo3Z?=
 =?us-ascii?Q?dXkxxgOG60KUE4tTWmOoN41SekkVtzDzQq1nSWHqcwW8tKA/PDq5BIK2jXD3?=
 =?us-ascii?Q?sUlTzcewXdyqQL+8sgohjO7B17+HvxuHlZs1F4PYtpfPN1/jw5HkSTIPMppT?=
 =?us-ascii?Q?ABSiu7TyJSJbfXU4n5+NjuwI2kRDrAJ86fc+2OlYbsFUeqvh9th9TEe/Ks0d?=
 =?us-ascii?Q?8cF3ln2r9W3Df95JHDwxUt+niVOTA9lKA0VMWO2z2jStsXU22nS5T5rv5jlf?=
 =?us-ascii?Q?a1a7G5QJRs3yc9UtR5PVvuNWQrbif6KnI+jB9x2nT/hwcyGrEOZaB6cCcv9U?=
 =?us-ascii?Q?r/T9dCCbEwHlMyx4d3xJz8unzOfpx39rSbgzReecaD2Awpgcp1F405HOD3Hs?=
 =?us-ascii?Q?d5CnJPTAvLcPWhQgXysnKFxA0kZnQaQn100bGD/DdUxPS2QeJAhbe5zNQIhR?=
 =?us-ascii?Q?0jpq87GjxiWLY3kA69/MwPGTwqRSDl8oYxMwt+Dm/Ti7gW4Z/26Sy3cjLP49?=
 =?us-ascii?Q?s/FN+9NPa4UiC9GQ0T9/mItFtPfDPjhpoYpJ5fh89LPHCG2eNNJAR/RZb4ii?=
 =?us-ascii?Q?/padnLQvL3W32l7nawq0OhTZEXIKlUt5KrmVOCNUjilKLw4+BT6mvXbUPh+x?=
 =?us-ascii?Q?8pvBA0ALq6dAM6miLE0ZzkShWjK1xb+z8b3SWxmCgRBXoh/iiVFYBay0ZNR1?=
 =?us-ascii?Q?2hZM5LfA/6ZM7h4HqkkxwYT0Fz4NaQ+UCAuLWU8QffVlHFXG/jSWd8hLvZJb?=
 =?us-ascii?Q?HaYQChu/XvAlsjDonX42hCpWs4XOGOfzA4+Xvz3xMXQ1p2quEOPshmb/li70?=
 =?us-ascii?Q?gIXCSGLRaxo5zTy+9c25tC9lEX4DFlFHSiYzbSVlsMyQ+yxMPt0c/jNc1p0t?=
 =?us-ascii?Q?bcEHP6qyXZpffwaul6ByHbWNP5BeV957scVU4YVVLZ638siRTS91zKPZCyIt?=
 =?us-ascii?Q?uJPjd8wnPy02S7keCKiLt7K+arBvcjf8xOULVSaupDu6A5J19CwwSKK8XI22?=
 =?us-ascii?Q?DySHRxmr429nJ1xB1fVDgG6s/oHN2F0xwI95DTn7OdVaUmoXgZAZGSjT5CKV?=
 =?us-ascii?Q?X2MvHR30+67k715xG4qELTYC4dSH5d+X2xvy+bYpxIHIGsDTil0oXJqS0fmo?=
 =?us-ascii?Q?/I+0X4bhzuzZWk5OInrLupYYPhzj3t6HooppcjsD01KzFAJo+SHgVNTJ4OhT?=
 =?us-ascii?Q?caSQmZjcNJ3c8RCnI1LbhaDP14oJK7kr74DIaIit5QC6fz2LPWvwOufJ3r78?=
 =?us-ascii?Q?vC2dqpXxBE5/uTxbMf4hqOZ6vNPwti/Zu/XzSeXTtvbpqbgsN9UL+iCcV3NG?=
 =?us-ascii?Q?3wzJDsgN5ASa2pGBcUV+SiArxddQcLOS6+nHTdtuYu/mQNQRde7YtcIR3cLK?=
 =?us-ascii?Q?F3ibYOCn/vnDBzhtjNrlZ5fo+oOWI8vFtaxW/MyUPzaQiP+8SG1fxrXXhwZe?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	S2x8mheloa0r3E0qodfFgStPIHaxptYqjVMXE0muiYrWPYQ7Hk+znJu4LDDp0+QvRPt2Pn1Lc8Xge0W8zirJAFxSoKS0FrR+ebgfAVBcE9JyecJVkvvrESxz6xdzf+rK4Cs528lnQys4ME1hZMOjATYwo1C9z5rIvckpUW083sijNmqBW9e8uIVDqu84rxFBf73nMxxgIOwi8R+q3ET6yI/10OGI/n/4vliI+W9fvoGKQqC2nIFBSUNoAqwU32PxB4vpeiBVeSGS/AAXFbCwJJvQsmR7tjEA1eA0ifPyekTefAtZ6b2vKI9p6KEACpsM6f41sf374clqe+Gwnfkb5TKsekUzxUXGLPNp5WLCOL3JhpLrCX1aMsfrXq0El0M+JAfJk/3SIURNfAeoDf20nV2MEzuAML/g3IaXbdfLhtiShodoJNGqERoogSuztuo3FrFAy/HQ+fDDRF0pNEsxjW8/Zw6NLWTq+j4CPTC5RHwvFJmYnSvULPmFHE0HiT+t9V3JHGX4Ti+XCX7WHwQ8VWPZ5hKirBiF5W26WXb8+FUbBcXxqJUxGxozEvy4LwmulOACVuxzwN6zwSIcCCAemmyy9Xmg4t0Lj0d1SXHcXWg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0fbf81a-861d-424c-0551-08dc7eae3db8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:40.6160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Prq78Ko0cyviBoRkbF0vdyMKx5QsY1uSw8YoLT1PujeFvJY2OTnyA1mOrwjlNh81Anxi061JS+ZXk596Xq2XMXkblB5cFd0omCSQvZEQGV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-GUID: 5pmUGxdK3pO5T28L4qHVXxjGgt3BqGry
X-Proofpoint-ORIG-GUID: 5pmUGxdK3pO5T28L4qHVXxjGgt3BqGry

When updating the task's runtime statistics via update_curr()
or entity_tick(), we call resched_curr() to resched if needed.

Refactor update_curr() and entity_tick() to only update the stats
and deferring any rescheduling needed to task_tick_fair() or
update_curr().

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Suggested-by: Peter Ziljstra <peterz@infradead.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/fair.c | 54 ++++++++++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c5171c247466..dd34709f294c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -981,10 +981,10 @@ static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
  * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
  * this is probably good enough.
  */
-static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	if ((s64)(se->vruntime - se->deadline) < 0)
-		return;
+		return false;
 
 	/*
 	 * For EEVDF the virtual time slope is determined by w_i (iow.
@@ -1002,9 +1002,11 @@ static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 * The task has consumed its request, reschedule.
 	 */
 	if (cfs_rq->nr_running > 1) {
-		resched_curr(rq_of(cfs_rq));
 		clear_buddies(cfs_rq, se);
+		return true;
 	}
+
+	return false;
 }
 
 #include "pelt.h"
@@ -1159,26 +1161,35 @@ s64 update_curr_common(struct rq *rq)
 /*
  * Update the current task's runtime statistics.
  */
-static void update_curr(struct cfs_rq *cfs_rq)
+static bool __update_curr(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
 	s64 delta_exec;
+	bool resched;
 
 	if (unlikely(!curr))
-		return;
+		return false;
 
 	delta_exec = update_curr_se(rq_of(cfs_rq), curr);
 	if (unlikely(delta_exec <= 0))
-		return;
+		return false;
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
-	update_deadline(cfs_rq, curr);
+	resched = update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr))
 		update_curr_task(task_of(curr), delta_exec);
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
+
+	return resched;
+}
+
+static void update_curr(struct cfs_rq *cfs_rq)
+{
+	if (__update_curr(cfs_rq))
+		resched_curr(rq_of(cfs_rq));
 }
 
 static void update_curr_fair(struct rq *rq)
@@ -5499,13 +5510,13 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 	cfs_rq->curr = NULL;
 }
 
-static void
-entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
+static bool
+entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
 	/*
 	 * Update run-time statistics of the 'current'.
 	 */
-	update_curr(cfs_rq);
+	bool resched = __update_curr(cfs_rq);
 
 	/*
 	 * Ensure that runnable average is periodically updated.
@@ -5513,22 +5524,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
 	update_load_avg(cfs_rq, curr, UPDATE_TG);
 	update_cfs_group(curr);
 
-#ifdef CONFIG_SCHED_HRTICK
-	/*
-	 * queued ticks are scheduled to match the slice, so don't bother
-	 * validating it and just reschedule.
-	 */
-	if (queued) {
-		resched_curr(rq_of(cfs_rq));
-		return;
-	}
-	/*
-	 * don't let the period tick interfere with the hrtick preemption
-	 */
-	if (!sched_feat(DOUBLE_TICK) &&
-			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
-		return;
-#endif
+	return resched;
 }
 
 
@@ -12611,12 +12607,16 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 {
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &curr->se;
+	bool resched = false;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
-		entity_tick(cfs_rq, se, queued);
+		resched |= entity_tick(cfs_rq, se);
 	}
 
+	if (resched)
+		resched_curr(rq);
+
 	if (static_branch_unlikely(&sched_numa_balancing))
 		task_tick_numa(rq, curr);
 
-- 
2.31.1


