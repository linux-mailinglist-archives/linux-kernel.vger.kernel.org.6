Return-Path: <linux-kernel+bounces-197814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582178D6F8C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F5B2825AC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6906F14F13E;
	Sat,  1 Jun 2024 11:48:16 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8961E4B0
	for <linux-kernel@vger.kernel.org>; Sat,  1 Jun 2024 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717242495; cv=fail; b=eZZMNwvmBQQijQNdmvOaoWVC+0AHOSXrP/nDXNHtuawG79LJHirUbr3WXxNwn379CCVdjDAomaNq+5TDqUW0Mp7WNGA1e+BMZvyC5Tn2UZHiUM4uW5aG+9rgpuQuLfe8JL5rbhw+R+iLFQ6upERJASXcrDgqYYF+wr8WNU2YKUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717242495; c=relaxed/simple;
	bh=UNwubasDmJehVmn7gbEB2gHUEa7pBh9qv/QCRANGecY=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=BTAgGpmd8YSoZMroqfglOnYpXGU3DkhklMpOhBauZpahJCWA8xwD1uxdECumhmf3Cuvq9UipeZsHrYLe53czNydxFLr2cwfBS0dnXi+Yp19jcHExoyEzzwOBRrB+BzaAs6JBdY68uE8IE6M1sUwJ9PaYWC9nKb+QT88EgAF/XC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 451498L5010546;
	Sat, 1 Jun 2024 11:47:26 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DL2Pw04BiJwV5?=
 =?UTF-8?Q?JRVOu8yWV5n8nYcoe9qwkfHZguvLgmI=3D;_b=3DfRWem+foq0Myuen4wogLIms?=
 =?UTF-8?Q?vEEwuygGwTyNhOBi4M/lStSQrer/7xoqmoENPTVBCmY4V_/KkPRw97pLCIHzXV0?=
 =?UTF-8?Q?mU1n74oI5c2hDJKVe2j9aD3noDNI25Q9cniU1wk3riEF+sqGC0w_xnbfLnJmXth?=
 =?UTF-8?Q?SAKH2SCtDtPCCzqwf9I/GPCdiEFiVuIfjmFx69r1ChAkjFiMpQ2EOq7QD_oLlq7?=
 =?UTF-8?Q?Mv1gRnFjwTQRAm1yOyEPLmRGciKMgBPZch/7DTW5NlRl08Ds+2f5G8XtEjRn1mt?=
 =?UTF-8?Q?_8aVxcNLROpVgGL234SvuKAvhCJHYAgpruG2916Dxzwjzw0aDUKS6/hUcuo2aLW?=
 =?UTF-8?Q?zC8i0C_OA=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv6u0bb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Jun 2024 11:47:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4517oRxd007224;
	Sat, 1 Jun 2024 11:47:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yft34srnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Jun 2024 11:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8kzOzo9JoHmNof4/w/WuLDUdqnMT5ueCbS5H6bgJOBsBZTiy/zN9BjakJvVCj2SWES2LKN0122LrmNkZphMC8NiisuZtY49v9EwIRvIw5mzyeOfZPvW8Ti/flzxhoulr0Yi+ZykiIBTrpaLUsRyCO5zt995gnVrVTXpdRMK/D8CK6kGoo0FtnmQlSBwYZWTel7fs3MuCDrwz3nDR0k6DID4jciVire0dme77wkQtptQBxXC1Aus8ZiHTHTikzob3SRn/voncivCFrnsxxQFKqT9hIdpjxoq6LBmQr5qOcr980FRQTPmN/nvYTZ4JSDk5saPuLt68n5ERtiNbIos4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2Pw04BiJwV5JRVOu8yWV5n8nYcoe9qwkfHZguvLgmI=;
 b=YzC13kTOspVU7/pw3GqRo6jdstirvEdcxnMTDdyKfacea3C3yO06dhq32PHu0eppPmDpxM1tcCV1H6qteevod4v5FXw1nsKzOrexSPVFmcaI5cpO/HdAZ0KLZGNQyXk/sSNXux26oupzv9oK0saJD0uDU3+YD8TSgxi0vlon8r4gyaaCTD//vSs54zY+XyaMcHiQWeko+ah2awM+ljBjItY0FIWYZhwRp9BH0H/RkaIo3uvjAXrSyIYA5bd8s2/Ws+6MHYpa4tlXCDHYDtU+jp+pZALC2d6CRc7LvLI6PJdh5rkKr4J7yc2gX/lVOavu3iaIFDRy9JjIwma3xTbkOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2Pw04BiJwV5JRVOu8yWV5n8nYcoe9qwkfHZguvLgmI=;
 b=qe1aMdthztK3lzzm37mNcP7lcAFySSCkum2pAY7/jPaY50hGqTG6OJKpTkoHS6b372Ou7mAfCK87qEGlBx30gfb7Y8XTFJWUOWcw74QS8p2l/zSg0UZkKInK9ZP89CsXjhEt0/juHzQNSEeMTQKQeuaa6ov0fEoJl3i1IdVDUcQ=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA3PR10MB8089.namprd10.prod.outlook.com (2603:10b6:208:504::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Sat, 1 Jun
 2024 11:47:22 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::e085:31f:84d1:e51a]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::e085:31f:84d1:e51a%7]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 11:47:22 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com>
Date: Sat, 01 Jun 2024 04:47:09 -0700
Message-ID: <8734pw51he.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0094.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::47) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA3PR10MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 738fa9a4-56a6-4578-190d-08dc82309813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OZrCpgYMpTqXRcXfCwIPnIgzIuxPlqexzJWD9jsjbKQncUxT+szfj/w9MiW2?=
 =?us-ascii?Q?Xu0nWRT3zAjDg+oLEX5H0e0oqogd1Utr8dMB1VeIARfuwqZSpy+LR/b3IyK6?=
 =?us-ascii?Q?LvXcqBb9+FHUUz4KJds/bRzbAEYTl9CCZ6rJqp4QUG4pMo5k8hv6WxjENI59?=
 =?us-ascii?Q?cwNfysKqmUoOvi8FSNcwUVT5IIYZbKLg8in7gpJxGCZ+c+rYfFVAFKbLeS5d?=
 =?us-ascii?Q?sYwUVP3jb1+SWTr/T9eyaXtBhFqIN0rv58AInRYTSeqwsHj03xDgQRXVYR8O?=
 =?us-ascii?Q?ae+MHbu9A2pdWTuKPNw+6StSjt0jD3tfN56Ad7zEbl4YXAA1CFYMBxact/B9?=
 =?us-ascii?Q?1wKvnoG2nHUtKlxlTXmlIxpPpQwS9f7/hzg6si8B/M6ATOJjAzCBZkc2SwVg?=
 =?us-ascii?Q?p8K17+v5FjaVSvpz+4Kd55Bw0Be7ZLnkjBo9tSX8x8bvqerhTXdS8tgwmGKN?=
 =?us-ascii?Q?Bv1TzKp7vTLJ52g4pxMDvaIQCD4y48AjGLUPjnVln5zJdzk+xgjPqY/bV8x+?=
 =?us-ascii?Q?U5pDU2f8MYaVirPnQgWG2jzGO1jsUnBBRiQmEYdRQB15tgSuhKxdu26dpdIV?=
 =?us-ascii?Q?Lr2o8BFGljYb7B8VPjwIIpODBxp+SqEtJhk79pHc0MSxXBRVjWOtk2+imFaZ?=
 =?us-ascii?Q?nLNwsYPJgzgUaK53S5qxyiqMYIBpmoITg3304L3pEgRqPOxM0DWBNcFJc9wv?=
 =?us-ascii?Q?2q5EZUHDEyo7axk6zhDFP8GHGX41cQlrNtH/PwiCufhOysrTL0nNdoo0KwBz?=
 =?us-ascii?Q?ptW55a54DXpYOHhOW652rBMdYasfexUT9nLe5W+mrqewLR34N2fDqk3R7l0k?=
 =?us-ascii?Q?VYsbmBGsfGp2hrIa2OzEmSRTTT+e5msBIiXqwdKho4kFliYubkVPI5VxCPFC?=
 =?us-ascii?Q?T82A8a9VTNi89aZqjNnCUO3cYCFuccOywPnB0U0yqNzbgmXGw7p10m3Yi4TE?=
 =?us-ascii?Q?4x99gxbgcdtMv8hva6dEDfLYe7ScgouMj4ODHJ3YqB5MQy3nFg+iYW/E3YHU?=
 =?us-ascii?Q?evkdMcO14FHZFjIbKWmP27olHEFECmQH5vN+tHiMgFIRIpUgK/AxITsMmFrE?=
 =?us-ascii?Q?z3cxqBm8Vgs5B3za5LfGkoiDNmutw1yAkn2gfhnoD4qdHpliviizpIOoSb+R?=
 =?us-ascii?Q?DrkVzEqj/BJ09GhR8IAeMLEtbx9xaTzpNNvO5wJ1BxZIpFvAL45Yf0/GPP/e?=
 =?us-ascii?Q?1148sH8vnkxlVRW8+2CBWk+g7FGW2BZn0QtXammkah3aiAkIJsF97IoBQQAL?=
 =?us-ascii?Q?e+KV0PVY2bATs2s10b++JMfecCWcL8FzaLvIVsb1Gg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?l675kSH773Q8c5HOgHnOFZn0YsyYfX1mcbNANaMSJ3ZvQ9eh+/78F5LtgbMo?=
 =?us-ascii?Q?QizxddQ4tTnlGAdSaaJ5oEIr07n6mb5Ap08rhvWU8qv+X798vqcy5d6UU/BK?=
 =?us-ascii?Q?/KiO80WmWtX5+a+/FGfVcLF/o8Jm6+0roUOaSZjuxmaJwyoeYO6NKSfKeBVU?=
 =?us-ascii?Q?pvTRTZUuDXRWOcPxhXeL63IMGQN5qpbLy6pa1pwIH+K7I7851SKVxP2Fvsmg?=
 =?us-ascii?Q?M8ziP3dvKrHUzpswf6to5FQh4DlvkIJUYXkNh0qpi9CDQSSzocpXBOLZ6Sk9?=
 =?us-ascii?Q?bzGBg2dlo6hFbmRTpI700Oo5diFv2hTSCb4v5NqjNpIeFB68hqgsrGxajajj?=
 =?us-ascii?Q?w3uD1VadD04lL+LPulM9nCAx1Zuwqt9TofR1UGNpwXmP8zWtLGQRY8l3tIDQ?=
 =?us-ascii?Q?DrsKbmKQVXMZmwb9XwUsEyByIgVdfzE7ZKE/aKmwk4itzfQbF42fFF/O3KD1?=
 =?us-ascii?Q?UpTtY/H+3AmdyUGNl+mAJORu+GgqSsTibLrR50Z0a/6KUfbwd4M0O8fpun+g?=
 =?us-ascii?Q?QFJCOJFBTanASaWaLgQHnClFficXYVRmKKIV8ovfb5BScxQhQZt+yWgx5WEF?=
 =?us-ascii?Q?MMAZ1eS+z5viCmsFFERvo6pfX+J61EwQAWc3xpxb4f0vhtb0y19yIuvxgQPk?=
 =?us-ascii?Q?VtNtgVwpWCYntezkdAM08/BaGSnkuJbbsS2h1AvmHVQeEI62tIUli3CLtSK4?=
 =?us-ascii?Q?sjnGnH2Xrr7nSPbtS5siZynKGC5jtpt6liUrgaUyrLIwLe0+RDTojVCZXK8W?=
 =?us-ascii?Q?0Pt6sHouWzpU9UWVJW/Xz9CDylc+S2lDg9MBz4hFBQWDVrgNLHN8qyBk7y6k?=
 =?us-ascii?Q?mb9WpBfkxtsTIpCFHG9zRqkE7KS09U6CA4+MBwCC6IBMOh9ZgHNFTESvet15?=
 =?us-ascii?Q?sJtgWNdaPulWu0URMMPYSmOMjalkgtX/zVGNmJ9rlLT5YwOMBLMESbZ3Gfzx?=
 =?us-ascii?Q?B6cBbHZfkLBnTJoZaRowr8j3KCTxjj8DkpOHsHcluYuL19Wfn+oyM1SBORgM?=
 =?us-ascii?Q?JI+dIUI2l9AhTmaNhgXixS0doQCVjwZqJkQhrhGxgO+pv0k5Mss3Oy1euf5e?=
 =?us-ascii?Q?Rsq1b/LeWvc8Gf4kFlLKonv7WEsX944U+bzmY9OqBi9nPZ+pt412YSVc8euh?=
 =?us-ascii?Q?vSWs2oZ+zOaCfsDS+Q8iWG+aGG+j1qu3oT9JzdFeuJ6gSmMjEPGkm7X9TVgl?=
 =?us-ascii?Q?prIRK6PkvqZ1QKLUebW0FjkGqBD6cGamOPdeTkIkUaaSnfHdXJOpS0GoMGeu?=
 =?us-ascii?Q?WmqebAaTj+UIMjy2X81m5n/v5mC3MmwF1N/TWGGB+Z9u965NfB0IpsRI6aN3?=
 =?us-ascii?Q?7uWoeSpPiCKSYRdJ81G2aj9anN3h272UyCxSUmhxDrFPdX7I8lZbSvdicDyf?=
 =?us-ascii?Q?LWcCyFHSK3WXKHJxOy2LmPKryjYgv52oAcPyffWU/4KIxAgJtWwVRK49NInH?=
 =?us-ascii?Q?ZYmNAuwb7rhVtsO4Y1jgg5FTUKTQ5KbX4Tf5y7HNZscvC2x2MGtcYV/SHT4e?=
 =?us-ascii?Q?xXX5q5/N9OObdmIt705hUm9Yfy8oCt5GeW9ZVKGHElgHbrqrhQQkOmslKQOw?=
 =?us-ascii?Q?MmJSI+T0fsmfqgnV7RH5kSm8nKKFHlMdGnUFqQFFpOm4aDbLFKXC6L2UFmd1?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kmkv3iYtPUJB66S0fRSNm6nluxrYf4PB+ML17G6fPgD1O9IPKzhJ5y0aV8TpZDgeUOPq6gYDDnKOFgZHnaNeGBiKdMhOZPkTtmh55li+Y0h+sI92KCX4UQjab2s6jC8SN7KK4vK0g82U2tWGRGjL6w+Ez6lCg9UfmOD80q4auw0tRnCG12pAdTN3gJNU8SnsW5L8riRf2L0xcYQ5Ds+lCYrdErPFejHHZUnLOKKRjMsnYNne28boL5oqF3T1O85PTj2F8SA/YY5zOg33UiaBw5Q01TtGkGdDv/qlZMBDFZcq+wXD4UV0L1rEVd9naG4tbgI6hIJuBEEHdbR9xNXUnRbhwkZnWIxO0wieTA7CbQyOsHjdWJHJKasjVi1ToNOCKTVv399dgCh2G7T+FxhzWx6x9yZEBsgCEnQe7DOlT1XuiuDTFPdWgK9WDtdAL3oSw1R4qovwhqsS9F7oxy8t1tqZOfbSP4x8vZD+0YmRD4fIu5Te+bTivI6x0fXdkYpgldJ45QSmlEojYD4WXsjCbWl8fmwJdYeF/170NgiJ5jhhXURXuo8cGbwKxTuzZmiTkMuRcb45HuecMrACcISgkMF1GIqXz1+v0xLdDZC9EwA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738fa9a4-56a6-4578-190d-08dc82309813
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 11:47:21.9874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrcBDUl79jSSrwZghDJSMj2ZFBYeBvWgDac/WypRS+X3BjJADXT7MXXkitEPkK+WWfX18bTbYzL5iSpTsZX7ZKl/WMPE4vjN61Yn+fMjeLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8089
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_05,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406010093
X-Proofpoint-ORIG-GUID: rqOzRSfRZdpxLLGlXVacTt73oByGMLFN
X-Proofpoint-GUID: rqOzRSfRZdpxLLGlXVacTt73oByGMLFN


Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> On 5/28/24 6:04 AM, Ankur Arora wrote:
>> Hi,
>>
>> This series adds a new scheduling model PREEMPT_AUTO, which like
>> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
>> preemption model. Unlike, PREEMPT_DYNAMIC, it doesn't depend
>> on explicit preemption points for the voluntary models.
>>
>> The series is based on Thomas' original proposal which he outlined
>> in [1], [2] and in his PoC [3].
>>
>> v2 mostly reworks v1, with one of the main changes having less
>> noisy need-resched-lazy related interfaces.
>> More details in the changelog below.
>>
>
> Hi Ankur. Thanks for the series.
>
> nit: had to manually patch 11,12,13 since it didnt apply cleanly on
> tip/master and tip/sched/core. Mostly due some word differences in the change.
>
> tip/master was at:
> commit e874df84d4a5f3ce50b04662b62b91e55b0760fc (HEAD -> master, origin/master, origin/HEAD)
> Merge: 5d145493a139 47ff30cc1be7
> Author: Ingo Molnar <mingo@kernel.org>
> Date:   Tue May 28 12:44:26 2024 +0200
>
>     Merge branch into tip/master: 'x86/percpu'
>
>
>
>> The v1 of the series is at [4] and the RFC at [5].
>>
>> Design
>> ==
>>
>> PREEMPT_AUTO works by always enabling CONFIG_PREEMPTION (and thus
>> PREEMPT_COUNT). This means that the scheduler can always safely
>> preempt. (This is identical to CONFIG_PREEMPT.)
>>
>> Having that, the next step is to make the rescheduling policy dependent
>> on the chosen scheduling model. Currently, the scheduler uses a single
>> need-resched bit (TIF_NEED_RESCHED) which it uses to state that a
>> reschedule is needed.
>> PREEMPT_AUTO extends this by adding an additional need-resched bit
>> (TIF_NEED_RESCHED_LAZY) which, with TIF_NEED_RESCHED now allows the
>> scheduler to express two kinds of rescheduling intent: schedule at
>> the earliest opportunity (TIF_NEED_RESCHED), or express a need for
>> rescheduling while allowing the task on the runqueue to run to
>> timeslice completion (TIF_NEED_RESCHED_LAZY).
>>
>> The scheduler decides which need-resched bits are chosen based on
>> the preemption model in use:
>>
>> 	       TIF_NEED_RESCHED        TIF_NEED_RESCHED_LAZY
>>
>> none		never   		always [*]
>> voluntary       higher sched class	other tasks [*]
>> full 		always                  never
>>
>> [*] some details elided.
>>
>> The last part of the puzzle is, when does preemption happen, or
>> alternately stated, when are the need-resched bits checked:
>>
>>                  exit-to-user    ret-to-kernel    preempt_count()
>>
>> NEED_RESCHED_LAZY     Y               N                N
>> NEED_RESCHED          Y               Y                Y
>>
>> Using NEED_RESCHED_LAZY allows for run-to-completion semantics when
>> none/voluntary preemption policies are in effect. And eager semantics
>> under full preemption.
>>
>> In addition, since this is driven purely by the scheduler (not
>> depending on cond_resched() placement and the like), there is enough
>> flexibility in the scheduler to cope with edge cases -- ex. a kernel
>> task not relinquishing CPU under NEED_RESCHED_LAZY can be handled by
>> simply upgrading to a full NEED_RESCHED which can use more coercive
>> instruments like resched IPI to induce a context-switch.
>>
>> Performance
>> ==
>> The performance in the basic tests (perf bench sched messaging, kernbench,
>> cyclictest) matches or improves what we see under PREEMPT_DYNAMIC.
>> (See patches
>>   "sched: support preempt=none under PREEMPT_AUTO"
>>   "sched: support preempt=full under PREEMPT_AUTO"
>>   "sched: handle preempt=voluntary under PREEMPT_AUTO")
>>
>> For a macro test, a colleague in Oracle's Exadata team tried two
>> OLTP benchmarks (on a 5.4.17 based Oracle kernel, with the v1 series
>> backported.)
>>
>> In both tests the data was cached on remote nodes (cells), and the
>> database nodes (compute) served client queries, with clients being
>> local in the first test and remote in the second.
>>
>> Compute node: Oracle E5, dual socket AMD EPYC 9J14, KVM guest (380 CPUs)
>> Cells (11 nodes): Oracle E5, dual socket AMD EPYC 9334, 128 CPUs
>>
>>
>> 				  PREEMPT_VOLUNTARY                        PREEMPT_AUTO
>> 				                                        (preempt=voluntary)
>>                               ==============================      =============================
>>                       clients  throughput    cpu-usage            throughput     cpu-usage         Gain
>>                                (tx/min)    (utime %/stime %)      (tx/min)    (utime %/stime %)
>> 		      -------  ----------  -----------------      ----------  -----------------   -------
>>
>>
>>   OLTP                  384     9,315,653     25/ 6                9,253,252       25/ 6            -0.7%
>>   benchmark	       1536    13,177,565     50/10               13,657,306       50/10            +3.6%
>>  (local clients)       3456    14,063,017     63/12               14,179,706       64/12            +0.8%
>>
>>
>>   OLTP                   96     8,973,985     17/ 2                8,924,926       17/ 2            -0.5%
>>   benchmark	        384    22,577,254     60/ 8               22,211,419       59/ 8            -1.6%
>>  (remote clients,      2304    25,882,857     82/11               25,536,100       82/11            -1.3%
>>   90/10 RW ratio)
>>
>>
>> (Both sets of tests have a fair amount of NW traffic since the query
>> tables etc are cached on the cells. Additionally, the first set,
>> given the local clients, stress the scheduler a bit more than the
>> second.)
>>
>> The comparative performance for both the tests is fairly close,
>> more or less within a margin of error.
>>
>> Raghu KT also tested v1 on an AMD Milan (2 node, 256 cpu,  512GB RAM):
>>
>> "
>>  a) Base kernel (6.7),
>>  b) v1, PREEMPT_AUTO, preempt=voluntary
>>  c) v1, PREEMPT_DYNAMIC, preempt=voluntary
>>  d) v1, PREEMPT_AUTO=y, preempt=voluntary, PREEMPT_RCU = y
>>
>>  Workloads I tested and their %gain,
>>                     case b           case c       case d
>>  NAS                +2.7%              +1.9%         +2.1%
>>  Hashjoin,          +0.0%              +0.0%         +0.0%
>>  Graph500,          -6.0%              +0.0%         +0.0%
>>  XSBench            +1.7%              +0.0%         +1.2%
>>
>>  (Note about the Graph500 numbers at [8].)
>>
>>  Did kernbench etc test from Mel's mmtests suite also. Did not notice
>>  much difference.
>> "
>>
>> One case where there is a significant performance drop is on powerpc,
>> seen running hackbench on a 320 core system (a test on a smaller system is
>> fine.) In theory there's no reason for this to only happen on powerpc
>> since most of the code is common, but I haven't been able to reproduce
>> it on x86 so far.
>>
>> All in all, I think the tests above show that this scheduling model has legs.
>> However, the none/voluntary models under PREEMPT_AUTO are conceptually
>> different enough from the current none/voluntary models that there
>> likely are workloads where performance would be subpar. That needs more
>> extensive testing to figure out the weak points.
>>
>>
>>
> Did test it again on PowerPC. Unfortunately numbers shows there is regression
> still compared to 6.10-rc1. This is done with preempt=none. I tried again on the
> smaller system too to confirm. For now I have done the comparison for the hackbench
> where highest regression was seen in v1.
>
> perf stat collected for 20 iterations show higher context switch and higher migrations.
> Could it be that LAZY bit is causing more context switches? or could it be something
> else? Could it be that more exit-to-user happens in PowerPC? will continue to debug.

Thanks for trying it out.

As you point out, context-switches and migrations are signficantly higher.

Definitely unexpected. I ran the same test on an x86 box
(Milan, 2x64 cores, 256 threads) and there I see no more than a ~4% difference.

  6.9.0/none.process.pipe.60:       170,719,761      context-switches          #    0.022 M/sec                    ( +-  0.19% )
  6.9.0/none.process.pipe.60:        16,871,449      cpu-migrations            #    0.002 M/sec                    ( +-  0.16% )
  6.9.0/none.process.pipe.60:      30.833112186 seconds time elapsed                                          ( +-  0.11% )

  6.9.0-00035-gc90017e055a6/none.process.pipe.60:       177,889,639      context-switches          #    0.023 M/sec                    ( +-  0.21% )
  6.9.0-00035-gc90017e055a6/none.process.pipe.60:        17,426,670      cpu-migrations            #    0.002 M/sec                    ( +-  0.41% )
  6.9.0-00035-gc90017e055a6/none.process.pipe.60:      30.731126312 seconds time elapsed                                          ( +-  0.07% )

Clearly there's something different going on powerpc. I'm travelling
right now, but will dig deeper into this once I get back.

Meanwhile can you check if the increased context-switches are voluntary or
involuntary (or what the division is)?


Thanks
Ankur

> Meanwhile, will do more test with other micro-benchmarks and post the results.
>
>
> More details below.
> CONFIG_HZ = 100
> ./hackbench -pipe 60 process 100000 loops
>
> ====================================================================================
> On the larger system. (40 Cores, 320CPUS)
> ====================================================================================
> 				6.10-rc1		+preempt_auto
> 				preempt=none		preempt=none
> 20 iterations avg value
> hackbench pipe(60)		26.403			32.368 ( -31.1%)
>
> ++++++++++++++++++
> baseline 6.10-rc1:
> ++++++++++++++++++
>  Performance counter stats for 'system wide' (20 runs):
>     168,980,939.76 msec cpu-clock                        # 6400.026 CPUs utilized               ( +-  6.59% )
>      6,299,247,371      context-switches                 #   70.596 K/sec                       ( +-  6.60% )
>        246,646,236      cpu-migrations                   #    2.764 K/sec                       ( +-  6.57% )
>          1,759,232      page-faults                      #   19.716 /sec                        ( +-  6.61% )
> 577,719,907,794,874      cycles                           #    6.475 GHz                         ( +-  6.60% )
> 226,392,778,622,410      instructions                     #    0.74  insn per cycle              ( +-  6.61% )
> 37,280,192,946,445      branches                         #  417.801 M/sec                       ( +-  6.61% )
>    166,456,311,053      branch-misses                    #    0.85% of all branches             ( +-  6.60% )
>
>             26.403 +- 0.166 seconds time elapsed  ( +-  0.63% )
>
> ++++++++++++
> preempt auto
> ++++++++++++
>  Performance counter stats for 'system wide' (20 runs):
>     207,154,235.95 msec cpu-clock                        # 6400.009 CPUs utilized               ( +-  6.64% )
>      9,337,462,696      context-switches                 #   85.645 K/sec                       ( +-  6.68% )
>        631,276,554      cpu-migrations                   #    5.790 K/sec                       ( +-  6.79% )
>          1,756,583      page-faults                      #   16.112 /sec                        ( +-  6.59% )
> 700,281,729,230,103      cycles                           #    6.423 GHz                         ( +-  6.64% )
> 254,713,123,656,485      instructions                     #    0.69  insn per cycle              ( +-  6.63% )
> 42,275,061,484,512      branches                         #  387.756 M/sec                       ( +-  6.63% )
>    231,944,216,106      branch-misses                    #    1.04% of all branches             ( +-  6.64% )
>
>             32.368 +- 0.200 seconds time elapsed  ( +-  0.62% )
>
>
> ============================================================================================
> Smaller system ( 12Cores, 96CPUS)
> ============================================================================================
> 				6.10-rc1		+preempt_auto
> 				preempt=none		preempt=none
> 20 iterations avg value
> hackbench pipe(60)		55.930			65.75 ( -17.6%)
>
> ++++++++++++++++++
> baseline 6.10-rc1:
> ++++++++++++++++++
>  Performance counter stats for 'system wide' (20 runs):
>     107,386,299.19 msec cpu-clock                        # 1920.003 CPUs utilized               ( +-  6.55% )
>      1,388,830,542      context-switches                 #   24.536 K/sec                       ( +-  6.19% )
>         44,538,641      cpu-migrations                   #  786.840 /sec                        ( +-  6.23% )
>          1,698,710      page-faults                      #   30.010 /sec                        ( +-  6.58% )
> 412,401,110,929,055      cycles                           #    7.286 GHz                         ( +-  6.54% )
> 192,380,094,075,743      instructions                     #    0.88  insn per cycle              ( +-  6.59% )
> 30,328,724,557,878      branches                         #  535.801 M/sec                       ( +-  6.58% )
>     99,642,840,901      branch-misses                    #    0.63% of all branches             ( +-  6.57% )
>
>             55.930 +- 0.509 seconds time elapsed  ( +-  0.91% )
>
>
> +++++++++++++++++
> v2_preempt_auto
> +++++++++++++++++
>  Performance counter stats for 'system wide' (20 runs):
>     126,244,029.04 msec cpu-clock                        # 1920.005 CPUs utilized               ( +-  6.51% )
>      2,563,720,294      context-switches                 #   38.356 K/sec                       ( +-  6.10% )
>        147,445,392      cpu-migrations                   #    2.206 K/sec                       ( +-  6.37% )
>          1,710,637      page-faults                      #   25.593 /sec                        ( +-  6.55% )
> 483,419,889,144,017      cycles                           #    7.232 GHz                         ( +-  6.51% )
> 210,788,030,476,548      instructions                     #    0.82  insn per cycle              ( +-  6.57% )
> 33,851,562,301,187      branches                         #  506.454 M/sec                       ( +-  6.56% )
>    134,059,721,699      branch-misses                    #    0.75% of all branches             ( +-  6.45% )
>
>              65.75 +- 1.06 seconds time elapsed  ( +-  1.61% )

So, the context-switches are meaningfully higher.

--
ankur

