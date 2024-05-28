Return-Path: <linux-kernel+bounces-191566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D287D8D10FE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED5D1F214A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED7954276;
	Tue, 28 May 2024 00:36:53 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AAA1799F
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856612; cv=fail; b=FMGM9RDwJwKIOu9E/kDpWQp0pDKSu0zkVdGWqTRxGgDbafygIFZXWcfnQdPm504ClXzfY1AiNbpF78dUNIz1XOvWyfqEzFemxilpm//T5btaN5f/HikPCPlUVkjTeduleTUV9KYE6KWi0urRCHdlAg4hKEs2CP3OM6TmqqU5ze0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856612; c=relaxed/simple;
	bh=iFKpZee1fiih3DocQaepBzxzBArRPMaL7R0VbWvCqfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XbKdse7mUWAYMSzUZWTbDkyOwatBFAWB16sUGAiv2Gdm/HOJ/1ebUqRXZppTHt6ASg8hYBmkSVDKZMTsut2Fk0AEbhuuIumVCuQVRFNTN/agkwRhmtRgVPRZKizxkC34g9GGKHTp9gLvRQa7FbRtuBG8JuAhCJjttu+CUeEQ0e0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RGYJfv025274;
	Tue, 28 May 2024 00:36:36 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DMJ63BXRqcRI5/Zucr20VFUaB4J75kGKHLO/sXoQkibU=3D;_b?=
 =?UTF-8?Q?=3DQodZoF4RICOTovBa94ZGR2+FkiJGbWczNGp9S9qCXmYiblhY5fRmSUI2KLaA?=
 =?UTF-8?Q?UMBwzAzO_Kp/45t1T2+GTfCq5SFnvvtMahpZTYu8f58zgBZinynTIbroZQ4T6Jp?=
 =?UTF-8?Q?nOo0ZZUoOn2Pss_iGmL/H4oZeyPgUfAXDZEwlD2jP02GwasKihSpTO37T+/6XRL?=
 =?UTF-8?Q?VBC1kwS/jIOqHUs4bKP+_KHC1Kb5+2nLYwPk9wm6wxnDGC2NHjb02JJgN6gmyxW?=
 =?UTF-8?Q?pquyZiVWMsS/Wb+7Sd+remCwhk_4YeBE3oRbv9M8CSSj9vZKSKctnrBspk9g/0V?=
 =?UTF-8?Q?b0wxaBCHR1Qz/c/6d+Sn8nafEjg6Ts00_1A=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8hu39ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RKcSXD037625;
	Tue, 28 May 2024 00:36:35 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc5057yax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+4q6nWOkK9csQAUtztZheRKIb3myGopFlGwOuzUNMUNkfwYEuVwArYx6Q/KidgzB9s23USBUx1WuuuxzMNXpT+k/NWNmY9cEsQr6OEwlcH9huKQiLxhGFZaNjTrk9cYIoNQo2ixfSO/cBqzYYpdqrIaQu2NRAJT7HYAldjvvseb2v2jhD6dV0bhZRchfvWHq1dj5n1/n/AW5mYk/1Wla8wyK4wLm751hwDT5bz8U+IdzmDydHNop0mn3V0tCx7dmg7dFQVhdCB7KuNkvd4snbE+01Vv7timM7Eu1mclsFd1Vgp9wPtYjezZgbmErDXusnTmsIhqR+jayvULXTJvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJ63BXRqcRI5/Zucr20VFUaB4J75kGKHLO/sXoQkibU=;
 b=Yj/R6wJ8PmdErC9TwPG6FFiiTQ02SOdYOrxGM/FnBnHxyaCs3RP4svUzvFHlQ36VffgFiGskcBO0CjtM9xP0u6WpgqIxKb5qRLWJU2F2qoWmOapcng6ok2Qemgr+bxQsR1Gg682UWPUQO27pcg0vXsCxU104zGeoUxcrADJsHfXG9MaASm5VT18CdPPY4RIdrx0wvu9y+XuP1ZjjXkCLAuloHuoSnODd7E5RmahhBqk1RicjpLBsHVus/OwYlYm6xKY/kfk4jIy+wytm+vthMO2hnBX7IuPJtsp9Zy10y7adu5GyuDKii1hKik7ZZ3xWzwN6kzXpRu5XnFEwcRziwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJ63BXRqcRI5/Zucr20VFUaB4J75kGKHLO/sXoQkibU=;
 b=NKeXn0J08HW0TLXsPLhIto8+mR0/P//OK4ruQxyH6dSGGIVp8akCC+m6sMqGK5HoFgKfHx3xZfZAKlDL1o7lhxS4M/YT/ilTZXiOdjTbCNuobwkKpct5+nssrndjPNx9yFzav6nrloj+ae0YPWOQIiDFrjrrM/zeR/oxru8Pg2s=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:32 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:32 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 22/35] sched: default preemption policy for PREEMPT_AUTO
Date: Mon, 27 May 2024 17:35:08 -0700
Message-Id: <20240528003521.979836-23-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0280.namprd03.prod.outlook.com
 (2603:10b6:303:b5::15) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 7342a89a-a794-4ea0-bbb4-08dc7eae38db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?f22SkDEo4jyH+UkE9QoZ1E0BJg7y73NkIQBwm3ZOIh7yyeXiP6kVSiWIsLYd?=
 =?us-ascii?Q?opH1Nthy3VmVEueOG+bzVsS6UT5rrWi5oMpVNtfeoi38h5jUD1irW1IyTcEG?=
 =?us-ascii?Q?NKHG2lZB001JqyT0EQuXnSfuQg/6U36qu3DrqHJPC9JHThFaALLWvajHWiaK?=
 =?us-ascii?Q?8SB2xZv6q3QpWAUWN2iOOA99ETjA8vuDGA+YTKadl3DYsQ1DmnRc7w+sQXGX?=
 =?us-ascii?Q?Kdhu+ZRw1x5ZtxQWJFtll0fG7ZonwWQCW50nyau1fuSpDI4VjLBz+96KgEio?=
 =?us-ascii?Q?sIFi83BvQjPQ4CwvLOZhW3dujBsOWtRTPE958KLi+h+JuxNH+1AmK9E2L4AE?=
 =?us-ascii?Q?E/moZ/BwQiXOgmPed5zbUod0m82dSfBSXxgJx64AIKWKV0GpFzOkPtlALmJ4?=
 =?us-ascii?Q?pn5xan5UdIF0fM2tzEDPWfquDdPNtQpvnDtNuYFU7eO/xUqGe/imRgpSWfsm?=
 =?us-ascii?Q?4M0q+NEUg7HOkRpJ7Ziflb/IYoEjfRpy0e6lqzBxHGgrcmhE2EcHiWsadfYi?=
 =?us-ascii?Q?5yECjChPSWuWdK6KGwdtQHq+QZu5awBqyBflNt8qmyukkBRLTLOYOWODbyh/?=
 =?us-ascii?Q?tbIuMckobXnAHOcjC5jbQIiIjLZMpewDOXYMDWrvluE7VvKdM04nLrt3uG8h?=
 =?us-ascii?Q?/SmlDAdWw5Sof7eB9HrMrLLDM0DHm4xVGevkqZOzTVdCmmJTHHLBGifPmFEa?=
 =?us-ascii?Q?coTXl5xpthxud5QGTlYOQQkDSTJf3gVQq5znj64nvb+ip4Ef4deAKlUPaPFa?=
 =?us-ascii?Q?ohhdvz50A7AJlo9LW6F+F4UAZlYw1+io+iNVZRQtUVLDqMDT6NUV1acPCObZ?=
 =?us-ascii?Q?pI2GAc/g9wtZQzKpzpcv9WDHoO9k4SebDhnU1lM4XGQ7JoHJL/dXkJYWQjI1?=
 =?us-ascii?Q?GmmqOWXPiQTrGS05IGXMPUrNMZbKkZ1jrzkyPO/49Fai0eCGJojc2bdxg2oR?=
 =?us-ascii?Q?jTKNXad0HzGUd8Ys5wLMg00+fnwoJMMFO9pLmLVrWN077o7o3NKc9XGYcl5k?=
 =?us-ascii?Q?hsqD7oH6suGgOVXGmYoKYwmHkcoLZveqpq8Vmdc4fc525rQ9xQHrsWmF2/R4?=
 =?us-ascii?Q?iNrSdn7LbXNi8e4NZ+egjKn2RaGeHUsB2DSu9nmEI2IIMBZBzQ3BdlcmU2G/?=
 =?us-ascii?Q?CKXibc5Am4IMg8jVET5MovZhZyjf0QmyjcRAmuOH/PIP/Y9okEaERLf/fASi?=
 =?us-ascii?Q?0imgT6QL7ul9jK986fEk4jIM+IIrOrBH8EfSMbrvkUl8ZblXsfCO5Mv4oZc?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iTOTyFtD3XGGTGxqxZ48DNec72l+Jac/ffwy6e56xVwOlvO2y1STGBaZ3Jsx?=
 =?us-ascii?Q?ksr9ms3WwfgGrUw9M38YSMWRErPmZdkWMtv9R1v0M0lY1P6odC9hkmN6F8i2?=
 =?us-ascii?Q?59urlQ35ViglhVicD7zcgXaBb+yuNvmbKid+oOLmOJ0CNrBzgQrszYX04VML?=
 =?us-ascii?Q?j/x++s8e8ewt+yXBJ/wNCksWMe5RGTGvnXD28sWKrou9C6Nc8OgBYra4AZ0G?=
 =?us-ascii?Q?q5ZZqOfsyTcze7qATCzeLbBPDfFbTVJTibRjr5PNH7H1yUivEkrfV8bXlGni?=
 =?us-ascii?Q?CYYxSd9S4Qh2iqqaII1Fn00qYUbRU3033PwK86YFxEHSINGsxD+fuyvzyic3?=
 =?us-ascii?Q?nUEntSTleK0B6DZ9UXaC/+pt/ChtIQusa/Wm/JKhfeJy7XH5b2nO7FWJrguN?=
 =?us-ascii?Q?C0cH3gbbKRCOVI+t/VcxAIjkRTFL4rVgRk3Ts0GEv3NqvUspth5s5SA6c8Lb?=
 =?us-ascii?Q?DouggWEf+RfsDm1ZiXjy0ikvXkTeUfLkOIw7VbiZeLq1heAmzWAayJTka3hy?=
 =?us-ascii?Q?7LHjsYqSjWExbCe2PooPQ82Jiv0ozptcvqDXrPH2JOw2+MH+T7vvALDtETA+?=
 =?us-ascii?Q?jyHB36/OHgd9xyE2SSH1i5ddtipGBDx3UJ0AG+B8bLMUCkCXzTlboxki7qLb?=
 =?us-ascii?Q?A8MKCHdWvs2KpWL/C0Wo5oQwMwciuupSn88xlH73FCVPNvd3PjIrx+lbTg9W?=
 =?us-ascii?Q?CizKwb0R73O2KNDyyEzD83xzCU/Vbol+3jWod/WVZ2O8NgrTrDJkYYqPabpE?=
 =?us-ascii?Q?ppF2tGmff7njXBLC0OD+Cn9xhoY7r9K9gkhGx2bqf9qy7S3hr1w/SncnBgj5?=
 =?us-ascii?Q?DUmOtKVOaC9IdFS/l42lHWGarXBIkNSqGGSqfREYWwvr9KUo0yuhGJGlDDFd?=
 =?us-ascii?Q?sFNoGWbUJntl4GtmgUVtvYzqQ52xL1ybo0wV0yWXi4ixbF1w1vYpET5sJtYu?=
 =?us-ascii?Q?SrHPKqjGmwn2Iehvo6TxLwJPbdYklJ+Fx0YAlSARRs8Ao1Qgvc+2DceCk1GG?=
 =?us-ascii?Q?Ms8PM6FNokEDsPb6E68ts7RaQXMgEVt1hf5S1NI9KYfJie31vOA7Fed3kG5u?=
 =?us-ascii?Q?m51sywCrAUD8xghCbgUKSd4e3igL7CjWExAOyy2JFfboLwUwpzFuEhBHwtgi?=
 =?us-ascii?Q?HWHY2CcN18h5xalsIX1UZQPpkzdnmxs2vIuwu+IxiwfmIGJFJbx8jGstDSkL?=
 =?us-ascii?Q?yLqqAOQibtyK0kjdm0Ii+Y46dHC0nKld4yXML72erR3VTrs9jmkcJhYLy6BH?=
 =?us-ascii?Q?jvGLkwRmRO9vek5mF4BoyfGqqxmZN4odUxQq+lfmLEfoICIHJhYlqgn8nbPk?=
 =?us-ascii?Q?wiBKjFMIOmQuiKFBjAxRJ28jhZQwNOya7vdH1DG8TIJ0nUIfpRuFcikijNOh?=
 =?us-ascii?Q?cXxJ5GgOIQfqroZKKm8ubXSWcfAWyEgUzoIbwOAADZYg47IkmhzFTYygvZnV?=
 =?us-ascii?Q?Aio6UgyxPrC7xXFaRMwaTu3pZwMuV0kwmI1oCnzNcCPAqjX8YR9gpjO0T5AZ?=
 =?us-ascii?Q?Gu9Jm+uBOjtNKoavggpriVaYKX8mVg7s4/B073M79X5T1sMrZUoIzVNtQIn1?=
 =?us-ascii?Q?cL851Of//DepTmnw2bgtze/jNYzO/WnFw6r8wE4bfAIM7miRmpZRNSjuIev6?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ly2EM6UM4aAvKArjVJI7OOrl+CFOy0h50muX0v40S9o22Hndv73+1qMThogMAvfqmZIRM+0LzA2b44AhDYCussvHnTQ49U3Sf0GuWiHgIgl52ZQ8Bcs5P8Ab7k5vKOT5HSUcO6scyK4WO2h/DCG2+KN/m8GDTd7a3LuLGRUPHI1sIyc0bVlphKqxtUdCeltGf16XynQ7Ci0dfq9OAxNQszyh69UCciYH0ZxvSSsjA5v22EEw3+j2N4F+ux7KyLrtppRNdNLi6v0s29+8kxa+P0RfAth6W1IABvjljWoytjF0TkN/Nb6TAo7hKoNBM50sJ/t9JMRXizmlkmtJICZkjGkFinwG8wAJrq+9u6qxaohI263YK/GeAFFcWEiHW7B5Q5CDK+bIeqC9fG3X8V3YdipSyPlqICtM0fhwzN5dMTv6gMGrqW2co5Btci+fapd0ZJg+A/BpCLJsAmDZvWeP9q8EzBme/PUBmgEvE2gHdCqbtDF1v6SrKppHdPG/AF/w+LwfoFmzOMBiciip0mOvjDtHn536tXWpsinqDJfKoXsAVvVqM1+l9NFl/qVShf4lozdqmbfn8wXBue3o9F2jYXjhb/cEwUAg/XY81GBc4wM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7342a89a-a794-4ea0-bbb4-08dc7eae38db
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:32.4176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BzfPRqL/VK87pC3yKMZ2XewEdeDeznaBfRyeB+/dUQCqI0JsLhWXIyRRpIqDvSu7M9/Ib1lgStAtc31b4eqt0C4UdN5H97fd9pEuizS4qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-ORIG-GUID: aQqOzeMttLR-9NyMO2nV5STKlGrXKaep
X-Proofpoint-GUID: aQqOzeMttLR-9NyMO2nV5STKlGrXKaep

Add resched_opt_translate() which determines the particular
need-resched flag based on scheduling policy.

Preemption models other than PREEMPT_AUTO: continue to use
tif_resched(RESCHED_NOW).

PREEMPT_AUTO: use tif_resched(RESCHED_LAZY) to reschedule at
the next exit-to-user.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c  | 30 ++++++++++++++++++++++++------
 kernel/sched/sched.h | 12 +++++++++++-
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 27b908cc9134..ee846dc9133b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1032,20 +1032,38 @@ void wake_up_q(struct wake_q_head *head)
 }
 
 /*
- * resched_curr - mark rq's current task 'to be rescheduled now'.
+ * For preemption models other than PREEMPT_AUTO: always schedule
+ * eagerly.
  *
- * On UP this means the setting of the need_resched flag, on SMP it
- * might also involve a cross-CPU call to trigger the scheduler on
- * the target CPU.
+ * For PREEMPT_AUTO: allow everything else to finish its time quanta, and
+ * mark for rescheduling at the next exit to user.
  */
-void resched_curr(struct rq *rq)
+static resched_t resched_opt_translate(struct task_struct *curr,
+				       enum resched_opt opt)
+{
+	if (!IS_ENABLED(CONFIG_PREEMPT_AUTO))
+		return RESCHED_NOW;
+
+	return RESCHED_LAZY;
+}
+
+/*
+ * __resched_curr - mark rq's current task 'to be rescheduled now'.
+ *
+ * On UP this means the setting of the appropriate need_resched flag.
+ * On SMP, in addition it might also involve a cross-CPU call to
+ * trigger the scheduler on the target CPU.
+ */
+void __resched_curr(struct rq *rq, enum resched_opt opt)
 {
 	struct task_struct *curr = rq->curr;
-	resched_t rs = RESCHED_NOW;
+	resched_t rs;
 	int cpu;
 
 	lockdep_assert_rq_held(rq);
 
+	rs = resched_opt_translate(curr, opt);
+
 	/*
 	 * TIF_NEED_RESCHED is the higher priority bit, so if it is already
 	 * set, nothing more to be done.
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c9239c0b0095..7013bd054a2f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2464,7 +2464,17 @@ extern void init_sched_fair_class(void);
 
 extern void reweight_task(struct task_struct *p, int prio);
 
-extern void resched_curr(struct rq *rq);
+enum resched_opt {
+	RESCHED_DEFAULT,
+};
+
+extern void __resched_curr(struct rq *rq, enum resched_opt opt);
+
+static inline void resched_curr(struct rq *rq)
+{
+	__resched_curr(rq, RESCHED_DEFAULT);
+}
+
 extern void resched_cpu(int cpu);
 
 extern struct rt_bandwidth def_rt_bandwidth;
-- 
2.31.1


