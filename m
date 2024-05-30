Return-Path: <linux-kernel+bounces-195143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC598D4825
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C821C21C09
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664A8EAF9;
	Thu, 30 May 2024 09:08:48 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E1183973
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060127; cv=fail; b=UnXkmDJs0zskECeaZiOONauSXBs6OyQJUk4cPuox5pP6Hs+ZLgw2raXlEGpnmQOL+MaXBmX+2qWOWNdillBq1lDbqApN3vzZ/LsJLvoE08dC5cMSdPg8s+wcNnDoz1nEy0IDREmos618sDZ4CyjGvbfdeDDNwWuUKeaplbexOUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060127; c=relaxed/simple;
	bh=EDIRRjcEm+zAvqDIBFa/fLX33Hke65q6ZwqhLTqd6Ew=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=aJZFD/f/SbOb5B0OC9YI0Q7jXwPVWh4MoG9YrrSJy+C7LBhUDc5T1GpnfHd2GT7o43e4AplA8O3Xr5K9pFtydGhv+JzIO8imUyts1Du6QZujajhHEVy4D183WhIK8Wx/LzMbopa+qzAgiyJbdyNNSk6IhYNbftN1Se+C7V3BFKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7nVH6005709;
	Thu, 30 May 2024 09:07:55 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-type:date:from:in-reply-to:message-id:mime-versio?=
 =?UTF-8?Q?n:references:subject:to;_s=3Dcorp-2023-11-20;_bh=3DioVhFuCs3Da9?=
 =?UTF-8?Q?BmuMBcHIq1V4ZmAoD59Jfa3Tlghy1CQ=3D;_b=3DHcfiraWMvEnsAHeh7TID8Qx?=
 =?UTF-8?Q?14J7MNcr7aWXYURZoo1GKB+f7KKct7adtlks79XqGBDUk_tWwldKgfCiFONloxy?=
 =?UTF-8?Q?xgmJhZXNf8PynBpnW8w/unwxTEEPkU37faq7AuTd0gvnH4uZvXT_2Za0EMFHIb6?=
 =?UTF-8?Q?Cj2mAhWEAfeOXEq9miPKf2UKtcvk4DrwR19VVh2970CaQWLhp2r0r1wX+_MLRhW?=
 =?UTF-8?Q?XQWkcLfqSX7XO9EBHgjuRc37XvTuzNwVKpTKUwjoLsxyt9ZRN+PSvpIzuMXjcS6?=
 =?UTF-8?Q?_U/QZ4lURddQrdUOXihJwFs/WHBBVP9emr442mRTtWDRptcoWCsAKAdDWTRiQjs?=
 =?UTF-8?Q?nVlKKi_Tw=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g48j1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 09:07:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7WfVo006229;
	Thu, 30 May 2024 09:07:54 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yd7c6p138-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 09:07:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6CnACkxUWpmd2B7ZmB+T0QjCnhiMHH41SvBt936aV6+UfIA7EB8XrO+rG5awlM4ap3c+X6VzKTNBcNMrDNmVI+mvLM3PxVHg9MGpNoK52MVsquX5ZGCYYzbbXAGE9Hi+MSyj2WqYJzbV80bhMn/EvDXEnPRPQaNFWxyHACfW5wle/OD3GL6upZg52EMGoR2VyKsgkuSuD0IPgEvDtPyboUBee14mni8+TjKimnBBD7wqN8teJjMWS8o1OEyZ78u6FBfuZXlkTIVSen9U8mntkKwkIyrmfOLZPWPNMHMrIIKV4MV+7Pd9Evm4yzbE6iozAelAtT+vU+5c2L2yeQkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioVhFuCs3Da9BmuMBcHIq1V4ZmAoD59Jfa3Tlghy1CQ=;
 b=Npl6OIRTjJNC15YpruKe10pjAPGyJhijRZzsDyY+e1MTf/1T3sAdS/2viPBgzQhyuwzgHVJ17wamV11AaWBzco/vxRximmMWmJRjYk9RGQOyl1aUr4lH/8fX3dNvrIYZcZayFzmxpnPtYzrpwzTirfER3xQoTuBBwy1f6feiaiIIKbHEmWFJMBmAKAcTqXVKRs7DRV7A48cVHme+DzwNxgF2x7Evi8w3llaEylCJnpPdsyEOK3BnnrJmemIefZyJL111eUstqx7K8AhhSDMmgiXfFIsd9KAEEvErbAySWbLRKtFAszYTV0LV2oLEgjeHlfr9V9BVQQqH93Aa9WmYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioVhFuCs3Da9BmuMBcHIq1V4ZmAoD59Jfa3Tlghy1CQ=;
 b=N29crKxqNf7Y7hxcCJgZcAmFcMB4bszPbA9kko7/G4YFIg9aussvuJ0LBOLO7Uplum5+mak83jSYMWhW6PMtLRwiTONkUWKUwf0eeshahRRjnGd4WeuuXv+XG/5A2fw06xGyDJBxsI71EwGXIfC3jc6p1OswSBU+UbAo4CkWeKA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB5898.namprd10.prod.outlook.com (2603:10b6:208:3d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 30 May
 2024 09:07:51 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 09:07:50 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-6-ankur.a.arora@oracle.com>
 <20240528155543.GA26599@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org, paulmck@kernel.org,
        rostedt@goodmis.org, mark.rutland@arm.com, juri.lelli@redhat.com,
        joel@joelfernandes.org, raghavendra.kt@amd.com, sshegde@linux.ibm.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2 05/35] thread_info: selector for TIF_NEED_RESCHED[_LAZY]
In-reply-to: <20240528155543.GA26599@noisy.programming.kicks-ass.net>
Date: Thu, 30 May 2024 02:07:42 -0700
Message-ID: <87bk4n7jmp.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0208.namprd04.prod.outlook.com
 (2603:10b6:303:86::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: cc2e409e-dfec-44d6-c0f7-08dc8087fae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KTSyNb76sf64YlcQqXdfvsg/ClwOPHywKL/UTQu94MTXPd5M9aWXLKSZL5Eq?=
 =?us-ascii?Q?gkrGwswYjsGBFSprjmEKO2Ljng/yz6lwmXfqaJi8D70PHEvSQseOmKctO39T?=
 =?us-ascii?Q?lP5tU7MeovjgEeGR8WQv4tutSRcsSAJ3ODZqnkRZJl2m6JuakSfFvPqLWTY8?=
 =?us-ascii?Q?EgE9MTGenoFSQmlzazYp7BmuT1gt9bJFDRO2fHkg7lQsOP+zF4cD32ux3tJF?=
 =?us-ascii?Q?tx3zivH0dD0WPyINlI9kcPv5AbnEsicgD/IbkfTZ0gU1E2LqtsDqi+O7PuiI?=
 =?us-ascii?Q?WTW230dPTgQPU2S+APAsUBwjmjXfhIyW9B03Ish/tY4T5qswqurFg5SwylMm?=
 =?us-ascii?Q?G6uA5uaLtoqsZLbah5VYHSCSqm67Wc/V9TT2ZrhCksPcGdCva/54qKxPHGK7?=
 =?us-ascii?Q?mRydwNoiM3jF45jaTgnfD7OM446WzTMukgGA8siSMeAqjTUy8i5e9qr8o6gs?=
 =?us-ascii?Q?USk9Hr/t7ezvmIz+z3myoPthi7n+6IyESs/VcltDXIKoIPRmiU/9rxXiAoi5?=
 =?us-ascii?Q?nNz6b+mhluetx2PMR63s/orJfxmkKs3syh5PCfDmxPurOxxLNay89zyWmhEo?=
 =?us-ascii?Q?HlRDQjRKtdN6LIdaWZay55HF+9eTtSvz9YIzNUicFf2rdRBgkFvLgKKiKwCv?=
 =?us-ascii?Q?cAFHB2VdZsbPngjvGE+ESeLFizeZ6RMYuBf4bgdxm6WjflJPBQ9FRiP049pH?=
 =?us-ascii?Q?yTe99F3Oy4c6Q1Qqdm25WHvoqww3Osj62FV7f7ylEZMQeub3tlfexLZZkA7Y?=
 =?us-ascii?Q?bMGsCB0Ibklr/CDsBvAj8sNYeZ2uJa9e4Lz7GBxKwzY9OaO0xFa53jD0kmnt?=
 =?us-ascii?Q?1QMON/VWQ1cUmIbkKt4LprpYPg/ofVoVqvXr+ybbGb2J8IpSLSPPTYFrbe7r?=
 =?us-ascii?Q?Mb9PHKm9p6FTpMZTUkNNZNAufuoxo/7Z/WK6s1yUqKT6lm/1S2Ljfg+JK+K0?=
 =?us-ascii?Q?JeVr5xQz64k0TYZKLOb6smf+UDs+SYZen0moBt5kl1hRzoRlyT/VnyZPER9C?=
 =?us-ascii?Q?V2NFjEBuWi3Vn6G4e/IGh+vXluxebkO1bXl8Auh/gyUWHTdsaFI9fY7d1QN8?=
 =?us-ascii?Q?skL/kgTcDF8jWnNRDBHdA3b4QywXTNteE8SI7+9hw5jihlt3llNU1W9UcBUf?=
 =?us-ascii?Q?5rg/hNN01R+TeJa3zKd9wRkUCFYjbokQKjE8frmFll8zisE7X/LHPLno4FiS?=
 =?us-ascii?Q?K6c27KRK7FCpysnXgyB85SqQDy/sjyoa18AxLw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bwxwy8/q0GE5ptLU8GznyhCosI8GApFZjJcRFfsGsjbiD8fPOke8ydI973nK?=
 =?us-ascii?Q?zBiUCctA0KQcUIzSu3St8N3nhlv2sdW96mPkc/RzknSkmkHGcsIxLeuCs0sP?=
 =?us-ascii?Q?aF/IocQDB9DUJQlWVrRbHy7KpiUo/CNAIphaGEHCoi09Oct85Cigg/r8ylp8?=
 =?us-ascii?Q?4xbWbLStmb2vkSSE9LQP8XnWC3OtoAaadEe1i7ZJKjn1AN623loVdnZrYcMV?=
 =?us-ascii?Q?VODUxofbYzXhuQwDv9l0vE5KU9MJ943XllY5UCYjO1blmxtYh9le5vGtymjU?=
 =?us-ascii?Q?1QpyBRZPUV5B49WKBH6XddR0xJFqhwayImRi6kbzsUfn9CrtJBSBhZ3bGCFR?=
 =?us-ascii?Q?1KB1F22rQraNHbQnXfUQQ7P+8tBrHEJHKu8CXHYykkiNb5AFaETyVbzdvxfy?=
 =?us-ascii?Q?l0kwYOwhbdK3oj5QVOgXPxhtQ9vOqVVOaj+FFG56e3TqsA8L7Y/lg0sHvNXB?=
 =?us-ascii?Q?DNnNPzKRPfb8myszZzrMkKCnq5d+0hfqZPJvTuYc+1KXAHf/Cbj5nAnO5fip?=
 =?us-ascii?Q?b+LiYjK8h/dsNAtO+0axHnou3X5ZNSe9DwdG3ORMXn7eWcaq0+sULlbIeV7g?=
 =?us-ascii?Q?SbVZp2tPYRRNLoczZaaDZZ8LqZ3cUA5HKo1kK3Cr2Yc94WyaFb3UeiiqUR1v?=
 =?us-ascii?Q?LjjVh5TVTTPfVl6irgPhDo2Q1sJuxwI0BK/oQnR7HiE+UQPuVQS6zA+Aaprz?=
 =?us-ascii?Q?/d9gs+M2mb2v6fwnx4oiGPeszyaUbvelaFNQ87hab1JFFJmbmX5pmzCH9Mij?=
 =?us-ascii?Q?5OROJLdZwqd9FImNtYwQRquwq0relhJEAH3wnF3nLGkgWjIvm5Le0ft6neGb?=
 =?us-ascii?Q?G+ZRgQV8aRHk7UL3zxfGh6I8wJEgRjBeb4Wn5kvonJki1A2SRgUAPrBt/lbt?=
 =?us-ascii?Q?IAHOwEkeD7c8dPS2BphzJ8/rXK5cZwf10+iq23hI7u/vR3ETcs3V7R67bmri?=
 =?us-ascii?Q?bCxPCVOX/iKGj3wdT/SW75VL/tVcQJGOG1On/8JazAF7Ht0d62sm8ykJA7Cw?=
 =?us-ascii?Q?zUoDD3d5ZSe4eCnuFjcRPywZyYySpDoDj2Oej8S6xe0gYEa9+O63vkjzUnKm?=
 =?us-ascii?Q?iuyUZJ3Ale7VGJfgE7co5mEeqibHMOBNFmQL1CRasq0iXy6YlbUFJDw5Q3u+?=
 =?us-ascii?Q?UhRuXqlZUuR96WVEmrXuiMal2H5qfLuSaivkN3qK+8uE7rICltYmoFB/hxsv?=
 =?us-ascii?Q?hZcyJISsG9j3YDLqvHkFAfFL5yLf1m3JK2iOM9dOOGxLh7uwVOvPqAYB98W8?=
 =?us-ascii?Q?6/QyvDT29xOSguDmX8ZKGHLtKUql23ngT3MDaJq9kByVqT+MuVE4yAJrgswu?=
 =?us-ascii?Q?WHRGKN5YPtllracm6PmU3Xnt17AHeEzUcNUjHCibt/Gr3SJD5b81i3fwjxkl?=
 =?us-ascii?Q?TtV8Yrqba72QV9Ar5cARTlYt2j8vY2TOVFq7sn1pbUfXdwL3aRox90P6q6gc?=
 =?us-ascii?Q?UibYQBR5A1sHMBqtsu/mIH3b0TfzOxRwNz32C/t/SEEppQ/ar0kGp7aKWtcb?=
 =?us-ascii?Q?Z/kVDWvP2blxDVsRk4TYdHbphpyBRFPIy06IIBju6QVuNjQF9bZ6OzCLe2JD?=
 =?us-ascii?Q?N6M8ahKdcwlEDi/xEX6IGMjuFcNGIV9LrvGLScgRXkMnlzeI3zYVti882w44?=
 =?us-ascii?Q?3w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	N77pVMZI9BCKhLGYhWt1MUts+hcFN2MIFaOerzvE8cjhzb+8VCcoJc9k5j4lK8H1k9MaQ8yQ5an/p+TYUxl/sbLv+90ixItUcF4iYamy26w5Q2A2bJbD4WcOnDKY47g/X6s6iLDGLfFlh/UUU/0KTx563zc9NLrm52RJ5PhxwYI1jtzW1NfNfHy2pO2Q5G64GmeVRy+PvWOa3jRU7S3yKrrNmQ+4OpjAa5ml8wzngbDDbl4jo8rsHgu1FKjvcPWSQxEChQ77fTFKeBrl/r3kNUtt/JQxa12DNafckxQtO0BRdaLtyghcFuqRPdxaGFfNXmFJ/i7FcHiLbozEp/H+lmBvzDmA3M81T3zZ5fBDs+es0yB44e2OGwVLqFrgjkk/9ZaksGQnDKBuRkUCnoAtXeitEJUggpKnyz/GFTOtLIe/l41Yo3+V+b5hmPi6/zNm9U5JjQCv2gd+fBqkf2u4AMQaw7kJ08zCOx48DZcetn4IWaRcdiM2qIUnzHg/skbxYCNaGCZI3ovdiKu2mSh8pz9U49QtUMi6dP4zpc1/5m7iK/UgDLADNTokPLp83P257qi+wwPMxxxT6zFiD1b1BhpQoLuwp3irr2wuFrBlyLc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2e409e-dfec-44d6-c0f7-08dc8087fae8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 09:07:50.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2VUXRvmYVFw9eBzvE+s8AR1cC/5c0odxeJ9DMLZvai4QAKDRIuzLs1HRIsEL4AZCEU0SCB3FLAoyltq+JeMpxaalEZjdWQEbL2K30SdqXjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_06,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300067
X-Proofpoint-GUID: 1Ywl9d4zcn_MNCtGBu1x8IRwhBSeRHcV
X-Proofpoint-ORIG-GUID: 1Ywl9d4zcn_MNCtGBu1x8IRwhBSeRHcV


Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, May 27, 2024 at 05:34:51PM -0700, Ankur Arora wrote:
>> Define tif_resched() to serve as selector for the specific
>> need-resched flag: with tif_resched() mapping to TIF_NEED_RESCHED
>> or to TIF_NEED_RESCHED_LAZY.
>>
>> For !CONFIG_PREEMPT_AUTO, tif_resched() always evaluates
>> to TIF_NEED_RESCHED, preserving existing scheduling behaviour.
>>
>> Cc: Peter Ziljstra <peterz@infradead.org>
>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  include/linux/thread_info.h | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
>> index 06e13e7acbe2..65e5beedc915 100644
>> --- a/include/linux/thread_info.h
>> +++ b/include/linux/thread_info.h
>> @@ -71,6 +71,31 @@ enum syscall_work_bit {
>>  #define _TIF_NEED_RESCHED_LAZY _TIF_NEED_RESCHED
>>  #endif
>>
>> +typedef enum {
>> +	RESCHED_NOW = 0,
>> +	RESCHED_LAZY = 1,
>> +} resched_t;
>> +
>> +/*
>> + * tif_resched(r) maps to TIF_NEED_RESCHED[_LAZY] with CONFIG_PREEMPT_AUTO.
>> + *
>> + * For !CONFIG_PREEMPT_AUTO, both tif_resched(RESCHED_NOW) and
>> + * tif_resched(RESCHED_LAZY) reduce to the same value (TIF_NEED_RESCHED)
>> + * leaving any scheduling behaviour unchanged.
>> + */
>> +static __always_inline int tif_resched(resched_t rs)
>> +{
>> +	if (IS_ENABLED(CONFIG_PREEMPT_AUTO))
>> +		return (rs == RESCHED_NOW) ? TIF_NEED_RESCHED : TIF_NEED_RESCHED_LAZY;
>> +	else
>> +		return TIF_NEED_RESCHED;
>> +}
>
> Perhaps:
>
> 	if (IS_ENABLED(CONFIG_PREEMPT_AUTO) && rs == RESCHED_LAZY)
> 		return TIF_NEED_RESCHED_LAZY;
>
> 	return TIF_NEED_RESCHED;

This and similar other interface changes make it much clearer.
Thanks. Will fix.


--
ankur

