Return-Path: <linux-kernel+bounces-191575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC58D1107
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151CE1C20EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DDE13C8E4;
	Tue, 28 May 2024 00:37:17 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0951313C81B
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856636; cv=fail; b=so2pCYm1qVHk2D74UkgsATbNXhzUkjj+R0juKieYI9sr6C5xiZllRGuI6BrvJRV7IzYyJkFB+dLTpIqyBRPNa/IdspvrXiIC8QGstD03XARMzbWpVnpjhY6e7Dj+yLqzRMuK9HZGzpCpw3Mj4y8SrcWLoJmVycxj9wO9G88HVAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856636; c=relaxed/simple;
	bh=fE8Lj7oIdkYG+2IXF/V3Uk8Sx22gVS/2kjJiYpE2bJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PZYkvwLXAeedWANNWOdDRkYbA72wMspcYcL2ylyc9q3x60KgMorz18jYd8cP2ZZGNRRaR/emudpHfLfQWtt8A5In4KtX89q48dRRuKU0T7swrJELZRRJCWxHyOT5+ijn1lqPjIR3ShMomgshtmYcD3Htnuj0PNKv4UQk9PkYqJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RDI4aL025161;
	Tue, 28 May 2024 00:36:59 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DKEcOg6TTu5LjMdHM9GsPiktnEd8VxG7vmFKMgnemHPA=3D;_b?=
 =?UTF-8?Q?=3DSin+0aEnjZWTD5ovJOh+yzC1HoNaS00IgaXaU8aI6NDs2yJyYjiF4X7Jxsvh?=
 =?UTF-8?Q?HqaBW+wg_iaTcmWc1OQEGct7cOlmzj/w3tlE3oKOrjbAODvtFmyYYhweSIUCNPT?=
 =?UTF-8?Q?B8idFsZDQu8Ggn_IMqNiEAn17XTNxCFdK+g2m64A9pecaYiFRYbCmkDNMmQye+9?=
 =?UTF-8?Q?X0iX5s3Jc4HAM+DRGQOV_hgTTwLLz3vOwxpC62GsklqPW7csdbWDtfwGG/yszEW?=
 =?UTF-8?Q?r+tzIT83rQPiGFzZa801/nYdlX_uwveJuieNFIgqjj7Fa5RRyEPVE/3R5OuYJW9?=
 =?UTF-8?Q?zYgTfktqroqOgWBOM2s+arUTwW585OGN_1Q=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hg39cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RKdPcu037607;
	Tue, 28 May 2024 00:36:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5057yh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcjQarElSkTdC7tMnGThNP/nOGjZ8CjY/a4WfCWbNjp3FhXan7QZIeRyWswCuXG15UNSWNaXM+96t/2VfuoTvHguTw/bSrZ8cBiQS22xsxGQe2JXUtGCuZMp6AGBUBu3nN1BLAhzZCkxqo1pNpY5VVCh88g0LmrzwZ8sJIJe7oNOtQHlFuyHXzoyr6UD0Tto2JlchELXtzyBDZeq/+4ZWgt1cayTitZFWhCs+XyyW/8XG7Y+AufMCqoRvMDd95PfQelwJzAHIVkPYKsweXSc6t58r+0etAYtBcvjZt6W51uGGsekZ58r0Z26ffJ1QFTk4XJ89Z8H3C6RyIDv6hI9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEcOg6TTu5LjMdHM9GsPiktnEd8VxG7vmFKMgnemHPA=;
 b=A7RI2rA6Qbbpo4hpSy0kZZUkCSgfevkTjF3XLyQ3YvJWczCbSts/H1kSC/bwnZyb+9GjzUk8Pd5C8hTG43CoajSaek0IzAaBSnXTKroAF4Jx62E5iQey168P47GmncKHjFve7DBY55XFPIP93rH8M4XU4HmpCHkr7L3n8xKJkFszu3OTJbROjJVHdt3aXq45aM/sQZQLGMf9go8RiChQXHTxbGunL9TLPBA1zvlZQRfQMGkFyw8ekb47AtfhpsIg3dh50vk4bzSwUN3atqLKlk/eje0xQEVPp8fZDv/brsiTLRHXItSeIa9yjUdVfENDJIqVb8lTC3MB+uDzeaBZ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEcOg6TTu5LjMdHM9GsPiktnEd8VxG7vmFKMgnemHPA=;
 b=m7oMrNke2+woycUhwlGMrV04PbyUCk/D5feRGS0iAyVFNlFHwEVV92yqtUpSzU2xf1Qdfwfvm3BAb5oZM7Q1LQSBUVjVHjBSf6iwMuZOUko/u24UdhXfULc11nRXsIRakajG2IZLjQKbUBiLfLavJX44BJREovhSJ5mg1qDtm6w=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:56 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:56 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 30/35] sched: latency warn for TIF_NEED_RESCHED_LAZY
Date: Mon, 27 May 2024 17:35:16 -0700
Message-Id: <20240528003521.979836-31-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0358.namprd04.prod.outlook.com
 (2603:10b6:303:8a::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f0f6c5-4d22-4c35-9b63-08dc7eae4703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cmGhlHuJx1oEcLxBNKNoRC+NIGgcXUyynAofBhY1xiZhjE7AUHrGnol/5hpO?=
 =?us-ascii?Q?+sIM+vypbxR1T5uSvRkJOzZH0GRA8lKh4gBFWwdpDOMySTDLOe5uO7agoPbT?=
 =?us-ascii?Q?F9EOAGZMOtg8NmhydAVNZ1tbluDRluErtTLjGzzb7Z9jpHzlMT90h0kKeGl5?=
 =?us-ascii?Q?xfxUwg+JFGwCA2FNpwExM76uuipya5k6XHO7qWaOe50e8lfsixStrPwmqv9r?=
 =?us-ascii?Q?kvNRsb11F2jbJkrNZHuTBzNVNGTHW2MdDQL7INp+7XVOvhhPxBUXa8KkL4UE?=
 =?us-ascii?Q?n9ZzMGkDey4w+v9ZL3hDLo7i8oxK3lEDmesF6F+4sMCheGgtyT2gykwfIWwW?=
 =?us-ascii?Q?9bUpwcevYeyoc8VDBxUnPbeK4yB/r2Q5v01+cZu280m1BzgdlRa0bhFGGD0Z?=
 =?us-ascii?Q?yxdfTqqRFAs8+7L0ChBf2cbRq7ElkPftgFASUQgOEdjPCr4R05E0yxhUVUOy?=
 =?us-ascii?Q?Xwh2tiyrj9QHz+Nm3DCskS16pLaiDzpCs349JoqXFc/Em93qyKWie07nG5ay?=
 =?us-ascii?Q?sMsbW7BtOryvRK6Iml+q+kjHuPg37m9/8m24u09ael4SqsTccgbNK+ghimfk?=
 =?us-ascii?Q?/NL6Z5XgJq3kUaCQOLflGRBxfQY36Qm5XBs5i6uaaPHM9OsB1ZjUFuoYk83o?=
 =?us-ascii?Q?kS+nopzlBKr0q1rC9i3EX0MQk/nEnEFRYaGtoaVAM57qhelauBbNEtRkZEee?=
 =?us-ascii?Q?1gvZuGcgFxwa391HJZwX5MleX1830nbJo1c5owlk0nSx+m7Fdl8I2k2N4/p5?=
 =?us-ascii?Q?O+4udVpiwVFQ+0sQiiG1tDGTiNeFs70LdtBtroB57zv/XxCKQ45+atSh2TyZ?=
 =?us-ascii?Q?gvDZjr5SJW9WRMoXGOaMvvJVnjfvTgQbNr5NeXoOCh6AlcZX0a7ApYJ9FDKB?=
 =?us-ascii?Q?ImoNKqA6o/wW755UJ7P3YXVikXXgy2HdkrmACIUCStOQCvuFzG2pUyHDw1PR?=
 =?us-ascii?Q?GhLZ66ZgdGyxKQltU1Vp3lJPe0ZLyrR9/jbrmCKQ/eXyWpqWPHHmVg44dI2C?=
 =?us-ascii?Q?yx20PuovkRxoZkpGr/8sTJbm/B/z1yg5eIN39sqIpXA9SvtTz64y3UVbF9kl?=
 =?us-ascii?Q?dZiuADrm4rUxIz2DUblCcADFaKhzS7iaQzz5y5TiZVxcDnNuIdIW5h88sgb/?=
 =?us-ascii?Q?W+9N4AaT87cHDBnazbqw2dSo2QKROBMxeDGPg3OpWPCOHYMb9EyHOinbsaof?=
 =?us-ascii?Q?Lug94ck76Pv1sabVyWtj1691uWkgWxR2znGLGExZrsertjFIFDpeDWWfg6NY?=
 =?us-ascii?Q?Hu57aExg+7oPfh2xTRUyzJ4jjscwKBdDmqkaxcesqg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UWnnnbAIN1c4C9wQICynJ6k6tlj2vl6K9/HQkMpkmO8N3NSSmFLV8CW7Brsb?=
 =?us-ascii?Q?fJB/6es0TyW/UUyJ6r/a5C+U559Mpp4pp8GogFwdDQKIScacjP6qQndADeZn?=
 =?us-ascii?Q?aGEc6Arcj2nhrmNMgDbyB9lE2Ac8sYPX6fvRPQckNS5cjp32ci+itgLMa29i?=
 =?us-ascii?Q?GbSfw+/nR0wQxB8MH6sBUoxwPtqpu49INrDY/AzU7+P4Foc359d8QQpuVWe1?=
 =?us-ascii?Q?xLCbSpqwpM1KmONVq/uNUWOSSSH9aTYHJWOtRAWBJmwbgzbzQckixhWhQp7h?=
 =?us-ascii?Q?MbhAIw9gF5/L9w8/N+tYY5b/lFHZNKuKF1pGR3OmnM529E6dE8tcw9hNiK50?=
 =?us-ascii?Q?bc6yX4SYy7F41ppUJQq0Pebp1NPFwXARlVd/JxhhScoVew3/H5SZz3FzFbsV?=
 =?us-ascii?Q?cdJaJbN2vvrQAEmgw5eT+I5mMroc56qLLA7xq9R9d6jeZCAL1nolbaoFlfwq?=
 =?us-ascii?Q?jGVmytaiq5XuEEHQPhFWchetOqazV9XNy6dIlGeQoj0mGHcpzsmrod0YxXur?=
 =?us-ascii?Q?LAvVxD9E8qlJIAxRVsfLdXpV6beBH6WmBElukhs/Xm8MxPyoQsMNruYMNk5m?=
 =?us-ascii?Q?DwXib49GKeLHZ/t1I6ji5+9kkXCpYMKCndFhXn3bDLNkrW7u3uPP6KTD1jMN?=
 =?us-ascii?Q?MGD2LslsBYCG0z2ZRvzBTXg7bozYwXTlu7yvNHhGB6JLv1GTiDlgbUAAD3DL?=
 =?us-ascii?Q?f1UgJ4gLFefdQIinUGa5ws7a7+x//Ehld/uEfu6eiqM0/jw9wpPa23/uVLmx?=
 =?us-ascii?Q?yUpW0yq0xIQOJFONYuTuEC+0O9YqQTaAAGx0ERwhWR2lqJg9cPT0Mx9Vi1T7?=
 =?us-ascii?Q?51N1o/R/mfN99MePJzmBGx12glJV9fWo4qFodyPZ6Gdizzsx8JAzCLQVFdQm?=
 =?us-ascii?Q?JFrWKHgZpKdlPAJ0EAVAeLHAIKhSMrSp6982m21p23upv8smeA4stAC3MejL?=
 =?us-ascii?Q?3W+IoW4T2NQ9gO+twdaADkU7fpy6ovnMAPZ4JSgFWSRQfRThTEXQqo+v2lHT?=
 =?us-ascii?Q?ZKEU2t9v9b3j69/4a/LRq7TXE/wveaxm69xq1NNvvQcpBAN2Au+C9SlATqg5?=
 =?us-ascii?Q?vrUcTz5PDwMUUbgmiLHbyoSHprQqnlAfRGEoPWOClJB1duSR03SbdsXSmAKc?=
 =?us-ascii?Q?0TVYlmRmJbnG9pmCSZei8FTBKxZ7SxmX246uXsHSFBV9AVsOFBrq92yUsCFq?=
 =?us-ascii?Q?g2Wjeyq6MKOQOExrsYQ1UFrLsmY7hnOmqGH+h0hyg5hngA238nGE/hWAYbqR?=
 =?us-ascii?Q?ejjJOZTWkx89NejNPhXx1Q7lYVjfhGCMUQ6ROOrZNT2HgpM5FFfwgQQimS66?=
 =?us-ascii?Q?NMjtK8msYa9k0IQlGDQ7xJjrPUE1lQN0cHahOPIi7+9rg4fPHHwvyc3tzWov?=
 =?us-ascii?Q?jy1TD+yRVRuhSZGThGWyEFuAVsfxoXYqa2mbUwVwMPRAF6ilI6lP6ihTDA8o?=
 =?us-ascii?Q?e2QsGIFRPbfBS0mm9MfnGlqlg00o1HpsNqDRpo+/EAgsT5cjXJ1VbpE6s8IV?=
 =?us-ascii?Q?EozHt/1uIJzbVakmdNX9/u6yM+qSDSvlXPTI4283gvMKglbNUFSuIx39/581?=
 =?us-ascii?Q?Ffw1rWAK31g1IKP/2iwIaPKNIvOdSCQzYNW2a/zxIfHuFHCbKqrK28IkipF6?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	L33ocEgSmE+XIBfq27JAUoRxyxoxC37xdV0VjxkxqztnRTvZ82OgqI6QiGlhbPB6PSEQg8IyfgSwlajuTY85gGjeBII8m4QHlT+fHoBJdwPcRbPgpERy8Fn86ysnaN/WJ1nDoFLDoxwiFzdWWLoOiJUeHxrnbu8CH+JBP0NFx+I1me/TRNeo55lirwUPmOBDLgyFGYNSL5QIHeRwvY63TB7SkdrsGf3qCX1Qd81HtyqKWz9OO1Oew6Apigiv8FajYBYSRCMDWqwiXJoZtrdMmnR2fMPpzg037a2A74E01BcxixYdSM2c7KR6r/Ez32V7r6sqQFzeClZ5gDNm8yBEFm78uFZ7nky7JiH8z9RyIfQq46QC2Dgs4rIjeMvFeK++pY+FyqljFuJWGUaoSOhPaEI758UVjSzBoD7pR7Ady3saekkoS7EmOS0naZCauUM7oiCAHrhifvK0DZ50up2p7XO7gGdK68v4bb5LXJWBEInr2WPXBTcbj49BkDju6c42Z7NIHBdCcicZjqKXlAsqvjAjCFdAVebzLR4MSYWWurqq746A1Nazu0VTtk1bXNcsSOK8LAiacrg8Lk1iuBlvr0qv8oqkCoDCs70MrdyeKBY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f0f6c5-4d22-4c35-9b63-08dc7eae4703
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:56.1956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qn+jn/R7dt+AMla+e1tsZegFihs1MwNA20bKlcIeg7ekRjulUUVvH9gU8WR81qSpQu4tAqOt9zn0VrSfvuC8r25g53+r/cxvhpjOxpldFTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-GUID: t9mVAK44QA6DJhOergGtRERsRVzn5-Xf
X-Proofpoint-ORIG-GUID: t9mVAK44QA6DJhOergGtRERsRVzn5-Xf

resched_latency_warn() now also warns if TIF_NEED_RESCHED_LAZY is set
without rescheduling for more than the latency_warn_ms period.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Ziljstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/debug.c | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2bc3ae21a9d0..4f0ac90b7d47 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5673,7 +5673,7 @@ static u64 cpu_resched_latency(struct rq *rq)
 	if (sysctl_resched_latency_warn_once && warned_once)
 		return 0;
 
-	if (!need_resched() || !latency_warn_ms)
+	if ((!need_resched() && !need_resched_lazy()) || !latency_warn_ms)
 		return 0;
 
 	if (system_state == SYSTEM_BOOTING)
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e53f1b73bf4a..a1be40101844 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1114,9 +1114,12 @@ void proc_sched_set_task(struct task_struct *p)
 void resched_latency_warn(int cpu, u64 latency)
 {
 	static DEFINE_RATELIMIT_STATE(latency_check_ratelimit, 60 * 60 * HZ, 1);
+	char *nr;
+
+	nr = __tif_need_resched(RESCHED_NOW) ? "need_resched" : "need_resched_lazy";
 
 	WARN(__ratelimit(&latency_check_ratelimit),
-	     "sched: CPU %d need_resched set for > %llu ns (%d ticks) "
+	     "sched: CPU %d %s set for > %llu ns (%d ticks) "
 	     "without schedule\n",
-	     cpu, latency, cpu_rq(cpu)->ticks_without_resched);
+	     cpu, nr, latency, cpu_rq(cpu)->ticks_without_resched);
 }
-- 
2.31.1


