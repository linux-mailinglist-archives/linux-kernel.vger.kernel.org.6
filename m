Return-Path: <linux-kernel+bounces-297898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3412895BEE5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4ABC1F225C6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EFB1D31AD;
	Thu, 22 Aug 2024 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZYpnxnYt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J7xyziGl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8F01D2F51
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354831; cv=fail; b=ESeaEockEVhWtdTY1XWQmCJNNHIWrHeBTuIWcKBr8tNPa0MZ/gBBbLkzRhe5v60MqR55++HKZfvjD2pjqtKhNZ3sSzsWgLdzna4R+59YcZZJHErNpG5DLO7vcPcJqUaTCHEy+EspJHOQmssSU0+l+O+cUmU57UJmoyYs+1gbANI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354831; c=relaxed/simple;
	bh=P58uGWf10T14Go3xsX3Gq7tRhJBYzn8dlHpue7RZ9FM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VV/Il34xYGUYt0eAtQcm068RltlUyrXrtoK3gsTwqxZ6Y7iYRthhuCAg0H/yDHQpe4V6y3JzwJQMk0CUCZwmWjMoRxyBcXzS9f5DX2zkC5OQAf+YIx9Qr2i14QPpNuRlobnGwaC7o6EN6NbOdjv/363z2xsxAwFdFbyaUbfD6+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZYpnxnYt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J7xyziGl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMr1d026289;
	Thu, 22 Aug 2024 19:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=2k8vIZw4lxINxvd4XX+iaMyXmk11DEGFPw6/UBf8xuY=; b=
	ZYpnxnYtusDbMOdnGVMe7Snaz2B9kKhh5L19BADADm7oLcJ70U+ec4dBesFWoYQs
	l+yP8qqC2mAlSufmkTeZ76fuLhahqFfxVDTEXQBdGnuZ5B64B7HcvNjAGCxVBKnj
	A3KuNiD/BNRHC38ix001YQb+DLEQJHwUOUDKHG5ZDKbOEjycFOyU5GCOaVzi1k41
	azw55clO/N0plQCAmGRc1jrUdEo5xmG+sttZmBNN1Gk+3NzWLZjrzWyEgA3jG2rd
	RctsVUzLo1xeGKaY0cYbAsk97EUmC5wrX0K/9aJfRfXG3b6mOGCX3T8R+X4jjhsg
	CAtVkupmsPFCyK7xPUpUTQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m2djxyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJJOnV005646;
	Thu, 22 Aug 2024 19:26:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416bcu08bq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtS2lWwHosv5dqqVd4A2hDdHrPolpnfql7vF5Cd/IpDn0u/N3wNiWYi6AaefurhscMv7dm5M75zftcWP1vwJvFst0peuvXzuT+eVPFyqwKxp3tH8EZAV6yjQQiW/0vH8vpWLCEKJ+tIUpVSL83Kai05d3pa9otXPzhSR1rWVmTixZBidulxvbL21bXz6zJq9LJgqyX1Ve8WZm52ziNf22SKyZThVkYnYTe8znRzQtozQgWM1CSFjA+GnJQPKatf4aZt8MwrxNdHkVIjcjNPMkNWhuGq4fS0nK1kIDU8QBYsajOmpDx5r25FMIXy6KYyceqhRcdqGhTyaHnAhs0plLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2k8vIZw4lxINxvd4XX+iaMyXmk11DEGFPw6/UBf8xuY=;
 b=o6PdJhZH5k6il1QlEP4QdhXbxz1V9noi893PRs2PkhsdNzSUPZSNajO3yyvy7SWtD9My6soVQV+4QVMnwFAx3+kmGydZMIZs5S3T08toR5G61D6ZHRydywioGgshs6ZGREsP2JBS0vhr26TJX0xDVZG2c7CieKWrgBBOY8nE/bpwdQYlRwKxhBq2G67Rfe4sMMkoK959jyVIqlVUDwhcFQGqIcU5UIVV/a17TN+7IahuS+BuNAmnkCrvWE7mRU7JJr1hqhNK+/mqdfbGuINYwKbBm67ocJg79EF2ItvbHcpE/z9W+vkOyXDXUMvw6YmG1JiLbmk1osDRCHeASFBAJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2k8vIZw4lxINxvd4XX+iaMyXmk11DEGFPw6/UBf8xuY=;
 b=J7xyziGlt9qpmWf9AAJWX6I1CT94S09siIIhnjLM8P0vGYmr66D2BBd9PSXTa5Iuc46/wZStM8zdYXhS5XiUANqFgYZXoFQJh06LO1nw3TK6P64UJxKBMxekmIbTqCiH5D/D+kRs7xbRSLNTUKPBqo1BnRU1JQrLnG3q7snideU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 19:26:46 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:46 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v7 19/21] mm: Move may_expand_vm() check in mmap_region()
Date: Thu, 22 Aug 2024 15:25:41 -0400
Message-ID: <20240822192543.3359552-20-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::14) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 46e1499d-837b-4ddd-b9b2-08dcc2e05c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OBXVGMw08qUaPiIxfCQ+DNAlV3xXbKEdLnQWzANLbcag9U4DqieD/lfKRm1B?=
 =?us-ascii?Q?irmPAyHMQBTkRQOi+PqlGl28dJd0MfixuuW/SMwTHLwR4TGZO+GSzikx230Y?=
 =?us-ascii?Q?j+7CF/9uh3zUDjPbgHgFcQbNpZCIasLSXINS7bzPNRps4/q1ZTAkHad8E2mz?=
 =?us-ascii?Q?IbskJXydikg3aGoJFlXpARh4efBAapg6iXpg+E80SBXTVxyYkH9XTQCGr7Co?=
 =?us-ascii?Q?1Vom6+msX3Gpto80+wjgEeIH9pJmYagTE1ihaoHyq10taVcvg6fC0AxIIhpo?=
 =?us-ascii?Q?Y6B+1Q4EJCu7xk9yYzSLCy/fG1omaDx8G9XqB7EF2+9mAdjSinr3GJyKiCFf?=
 =?us-ascii?Q?Q6Y+bf+RS3ansz4F3Ty74MxsdD99VOluAOHgWklGPdDrP8bdDaV+7G5x3HiY?=
 =?us-ascii?Q?bsYdP6pP+6V0S4gbNzJ/nrCaIvlxtcc/QprUq4Ri74rlMOtDBDyRkSq7MXcs?=
 =?us-ascii?Q?b1CD6b8Lk25jWvlt40MOVigxhYp8lXBT7FeOUFPLuX2or8tQCeqkQcg4qEin?=
 =?us-ascii?Q?yZkmp+nmSltBc4LpSI08fS/GQ090GSMSqLt5iVu/tWOt4ggDSbWq4LE1jpMJ?=
 =?us-ascii?Q?XXQs/dSD3clpy4G+1dY9F/vIbrHEKqTBXRXV3xHcNZQZTjNz4nm1oXjfn0xP?=
 =?us-ascii?Q?fJQvyCWd6VBGN8dVwfdQ8vkPu4rkpf+e6k1RKSHqszigk2MuurjOgffqLZe8?=
 =?us-ascii?Q?IDyQeIjH8GjWypftKRYPOR3UaggDlZR5dRs/tFr/jhisvG2Ie0WZcSrVJz5d?=
 =?us-ascii?Q?zZwtbrglUkmZACVXV5KhkynC7BlnQKfohdcKjZMA292t9uCUhlR6Ma1tlqdK?=
 =?us-ascii?Q?KAN/0PoIHTrRuMp4MeDsInACKjOkggZ7JdVbLJMmdBNWUYUZ9cexXNjF48el?=
 =?us-ascii?Q?qwpu3YdZnoSPkcilT0GLOVH8vzh/kgXIn63hn4+5mn1SHYZ7esUvX2Emozb0?=
 =?us-ascii?Q?m3xaT1kGShPlx+CavqM+51z/Z2wYY2fpPDtcFWNZ08LonkVmQdAJrjyc/a81?=
 =?us-ascii?Q?bXP9ntHVTbXp3YoDf77X92tFMGZON/k/nDqDXlb4mCYz6I4fjYaeapsnHUC9?=
 =?us-ascii?Q?GTLgfpY8IEjVc11+cc3tZBllG5mayxQD5E3bk/NZaYyAAy3Qywm8N48dugSk?=
 =?us-ascii?Q?MtkVUjw9D+1Wz2gd/M9Y++JE6iZUhU78AR5TqE6ZbW4HWS16DQPE/IxRCRU6?=
 =?us-ascii?Q?/p9N9FSbpwVdknVhdWvNKAFzovQF7IHuGHoEyNmN1kgDEYwnnZa5K42niRkY?=
 =?us-ascii?Q?fgf5atV09IIchK/ZMSzUqCnKJQu2gJaIqTvXoy/W3Nk1wfEGtw/cxuZb8kUM?=
 =?us-ascii?Q?nIIp0/D/3Woqx9j4B2mktc1AFwfJ6Kw7dA+9ga/ViXW9dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3eizxDnOYYoppcNG/vBrFopCEGNd/L+jm8c4squqFVC/2GkXfe+YhqNHPHOk?=
 =?us-ascii?Q?WcWMIYTXIit7WM4Uw6kwd2ayG9bUr2ZmcDKZNdCaYRFduXAtXxmmc2Xb81+v?=
 =?us-ascii?Q?F64TuU3S6QdnwlpTTnIyIAmrhKLG9S8f5JZp1DM+MZLxHawFKtvm9APS3i86?=
 =?us-ascii?Q?oY/LFYcKgM8HKtRPqKaUqiVXhN2R7qaByTE5e6MC/Wy7qE583rLNdD9QwH2U?=
 =?us-ascii?Q?LRqzGppN+L85N1Wh6+HyDSEyRhGgAgZ4+wtrdA3JtB8BVYOrfuYk47hwHu7i?=
 =?us-ascii?Q?WFnpGzxFehaV/q4oCPKqlzHOXJiyQpJt6HJIGtPPaj6/omR8zhge3suBF4Nd?=
 =?us-ascii?Q?p3Fpsqi8Tt3AjKswiBsQXxrct5FCx7t+Jn+2sX1JaNXc/d4NkCorn8rW//Mo?=
 =?us-ascii?Q?+T9ACQaZh4xTshWs12Hj8nNTdpcQfVVjvsKpjKFSqdUBLrRKk0wCS0u+Z+yt?=
 =?us-ascii?Q?11uU7irAWSnoAaVQgHZxLq0uwetZ0yXEw+4CoJ+mZ1KGuHXH1ofsX50VZVyD?=
 =?us-ascii?Q?x3To8XS7HkEBHoQiVP08uKE04AolR1CbtDmsxqYuVgVKK8T94C5IP0+0huTC?=
 =?us-ascii?Q?OkkgVQcdLqqHvgZv5zp1tX7SBmHR1D4CUp/hqo6UMbfs1qj+80ZTxA5pii+d?=
 =?us-ascii?Q?y3D8+GPBj2ic93X8/KP31JXEpzZ/dfXRkEfgRhoLHMts0dSZbHZaNdhkhuy5?=
 =?us-ascii?Q?lcS41Cl5LnVE6ANQYmip/Usy4Y0FpLVGqAg/QqzGVnQt9H1VmskD5172ed0Z?=
 =?us-ascii?Q?9By/IKU2gSvVx/xLLxegX2qf65LMZobsky01WT99jPCc8guUD1kkEpluOLQL?=
 =?us-ascii?Q?AMqmdSEjOCOk4FSVg6wEa+lxFaUieDFNMj1cf8qllrD/rvmPvp71cSRY4rLB?=
 =?us-ascii?Q?2a8RvN0Eg98gzWECV4NlJTGhucReZuPfloM8BPL7f8NgJq7IhBLFOdQ6D9zj?=
 =?us-ascii?Q?pkbx6h5/2WWKZ8zQNUmCB2aEmSZ5qTSwGhsxsAxdR8+aTX6ug1+7KF3E+M04?=
 =?us-ascii?Q?0FhejVbRwK+zXYgs0sZuEodpVN/IiefZgzzUolikNIIGPeCwALiNhBb+SNAF?=
 =?us-ascii?Q?+dIKQSm9GwWo3W2aU7FeFis3BaJcsjetxvOUMDFIp1j6Fdo8x6JYdop3HVP7?=
 =?us-ascii?Q?U2SVkZmbikgFXmG8mHfjQoSRBNlSntE3RNYoqmLHia+9salgltCljB3Ci7IK?=
 =?us-ascii?Q?dVkXJU8ZszJS5ItmGNslNfxY4CUaxo4fSXDKugKPzZXioIflqsSP7usPBg7b?=
 =?us-ascii?Q?wGBcCPu6aqGqLzrF0tiCGwwBjOJ0sTEMe5ydyYnOavtMmxKHEMe06tvJNZaN?=
 =?us-ascii?Q?Ed1UvtTkQ5ZoLExsDDy/zeS67idPeW4pDxMtFKduoN/AS4uIFIByCEZs3BX2?=
 =?us-ascii?Q?U0s4Q+vlnWceGXrbCpn+rOZt7u0URejFU6Rs/j4fv5CgCJTq5XMW7OMJyXc2?=
 =?us-ascii?Q?4rG/Z46y541H3hmf+AleXzBD7r99obIG5EkhE2ep5mcPFZTameJzfEHx6Rct?=
 =?us-ascii?Q?gwJFhGI9+cdQAC4zN+Y9cxY0XTaTXwkzWwEzPWyN2KKsoYVZNPCDo05SpHvn?=
 =?us-ascii?Q?eb2whSF/8SdBFAn8OAHHxb6Q/VaWAl8nFQLYD4/aUtxpIk4hGYW1mDkJTDfL?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rhYRglO58dxL1klGcV8VQ1YywnOXgjrCt9Ar0Q92QkAafePBgxIySWrWy0C0YkHCQ6dS8C645NARlsLZP3cgKi2Ki2vW0ENVxERmP9Iz0hh4KeKdKUhmJnUB8iOGZHXU4+SbXXD3axAVfvw7/8mvWfNH3482S517g1VcR7aQJN+IYSJ9KbTqvgXo6EpOwndP5zJtSNk6E1xxv7cEMFoRHMLBQ2yH+UMM/znt8F8PQ+5gW2k7t+lSQSOV32iDiLRQ2C3Kz8rWF22FpTTqA9A93hx4G2qm+/vySV3SESP4zw/c5YtBObQ0BBPZXFV9oy/urtS/I0EN9P9a2MCydlni5JKFEPa1JPdBDCFxxwaAZUZZxgAoyRDC5RN9XodcVzjRF82dDSun91PyhpNndkbntF1MP7p9r2VtNNZPal64oY1w3AJ6GYWXHoNAy1p9/rO11HvJoJSRSQlKbBhRhIyMexZ/7pBWV2F+20PYWej/yimwAHmLarXioQ8RKYIwsAHDYBnja+3gSQADITB8fq6RdkmJtOZm1mQtvMzb1Zedt6xCBHxTQT+4/H0pY75LufkSTuI3WIgz1MZKlbwjzp6AMtn2mU/ETC3/ncMLURxsq/E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46e1499d-837b-4ddd-b9b2-08dcc2e05c33
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:45.6245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uw+L5/rREj/iQcg90wvYm4ZOEEY62aUYOtYjitVZQsgfEMM2A3Aho3UsudAVkfn5PH6XIIxfJq4U6FpNEgFK9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=878 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-GUID: rE9GjZmo35itfnvAhGFVqcBnA_aCbUwk
X-Proofpoint-ORIG-GUID: rE9GjZmo35itfnvAhGFVqcBnA_aCbUwk

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The may_expand_vm() check requires the count of the pages within the
munmap range.  Since this is needed for accounting and obtained later,
the reodering of ma_expand_vm() to later in the call stack, after the
vma munmap struct (vms) is initialised and the gather stage is
potentially run, will allow for a single loop over the vmas.  The gather
sage does not commit any work and so everything can be undone in the
case of a failure.

The MAP_FIXED page count is available after the vms_gather_munmap_vmas()
call, so use it instead of looping over the vmas twice.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 15 ++++-----------
 mm/vma.c  | 21 ---------------------
 mm/vma.h  |  3 ---
 3 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 51ab0bdb856c..5937607f6949 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1376,17 +1376,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	pgoff_t vm_pgoff;
 	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
-	unsigned long nr_pages, nr_accounted;
-
-	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
-
-	/*
-	 * Check against address space limit.
-	 * MAP_FIXED may remove pages of mappings that intersects with requested
-	 * mapping. Account for the pages it would unmap.
-	 */
-	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
-		return -ENOMEM;
 
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
@@ -1409,6 +1398,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 			vma_iter_next_range(&vmi);
 	}
 
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
+		goto abort_munmap;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
diff --git a/mm/vma.c b/mm/vma.c
index 91b027eb9a38..61d51677eaaf 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1645,27 +1645,6 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
 	return vma_fs_can_writeback(vma);
 }
 
-unsigned long count_vma_pages_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end,
-		unsigned long *nr_accounted)
-{
-	VMA_ITERATOR(vmi, mm, addr);
-	struct vm_area_struct *vma;
-	unsigned long nr_pages = 0;
-
-	*nr_accounted = 0;
-	for_each_vma_range(vmi, vma, end) {
-		unsigned long vm_start = max(addr, vma->vm_start);
-		unsigned long vm_end = min(end, vma->vm_end);
-
-		nr_pages += PHYS_PFN(vm_end - vm_start);
-		if (vma->vm_flags & VM_ACCOUNT)
-			*nr_accounted += PHYS_PFN(vm_end - vm_start);
-	}
-
-	return nr_pages;
-}
-
 static DEFINE_MUTEX(mm_all_locks_mutex);
 
 static void vm_lock_anon_vma(struct mm_struct *mm, struct anon_vma *anon_vma)
diff --git a/mm/vma.h b/mm/vma.h
index 8ca32d7cb846..7047fedce459 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -315,9 +315,6 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
 
 int mm_take_all_locks(struct mm_struct *mm);
 void mm_drop_all_locks(struct mm_struct *mm);
-unsigned long count_vma_pages_range(struct mm_struct *mm,
-				    unsigned long addr, unsigned long end,
-				    unsigned long *nr_accounted);
 
 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
 {
-- 
2.43.0


