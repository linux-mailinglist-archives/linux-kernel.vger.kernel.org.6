Return-Path: <linux-kernel+bounces-220169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6107390DDBE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D55C5280F93
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0333F17A92C;
	Tue, 18 Jun 2024 20:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QIprdqC3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bCqKYgR6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325291779A5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743727; cv=fail; b=D7HF1wVRVw/1/ZN3Hv+CNm+t2licrH8T3gE+NNqkPc6S7Kp7qRx22P+q4GkEOkvU0opqQbH0D8K4ONadkgH3fgA9ueye1seD/MJogP2tQ9hYeK5waBj+xmUgUqRj1M+BK2/eDqUf8J6b9+tIu9An3GOzoIUf8rE+wblFXfMDjH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743727; c=relaxed/simple;
	bh=2zssSrooZilwiEWD/VsLxSXUU9iFH4/4UAPjJ+nmQhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Js9F1lSqIUzmQqmDtgQrVteMUpXhTcWxPmNA5PWws0i5ByjASa9psj9SOnPLip8Y5iyuAE78mwa6UcqGCNNLkbJcUj5ScrA+he9zk7emx2Ghk1KuamTkCkH2I7VOFVRU1AOpoaDURPCXmLS5w680A9e0xmCLly0Za4W2uuqD0Os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QIprdqC3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bCqKYgR6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUxvU029821;
	Tue, 18 Jun 2024 20:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=zz6qNIKltTmXoHlX1g+R7AWUOp4OUnndefvednj8JZw=; b=
	QIprdqC3ja7oPgvSHDnTQJqt4sN4HVZPf77noJMVjv16C0J6pvDCCsQ+imyTS/XU
	bXBw2Le8I6//bepOgTkoElCBa5s8bQkegvfbQG+O80OF6VOwS1Sx0pnCn4cTQMES
	jclzu4RQs/scPGgAgQrHBGiyS7bmt4PjP6rsWTti3zXSwsrgXSJhQ6t3bdKTaaGF
	jQdnKKMXelOXbBMB2VuSs59ChjDa+AbkY261T9WWieB7Foowz8CZlJg5Hcsv6Xma
	9tqFwEP1poLahyeyCGYVhYZbX1Wm5pc0mHZiDxKScI39NGr0qT3AVPjrLZaucNv0
	3pWBZQqpEKBBKIoW//Xt/g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2js5tnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IK8ThE015724;
	Tue, 18 Jun 2024 20:48:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1deqw7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cdy4NUtHl+KKtlGxY5jnf+E62xpkjwA3s6M9MW14FieOs9jugK4QrVqB3UM2HuIqCbTC5AICU9Keotp65kpXTdZwaYBtQvBIheAGLJJiqPeWGfLskDL4Z3wVlUwEdxRWHiMoQ/csE5HJJE0xch9N9be0R84o10Y/v1a6CHKQrJNUECha2QYCCg/GqEhC8hkLT7s4MQSPhkw32P+E71HI696yc9D6GMfTyNaS0aJ/tefp00oL4D0BqROFerGzXB58ErCxPYrPwFg/HP7WUmKsJTI5mHucbw40fa75imAY6LJZFKVVIDFYf9h8Xhob9FdCloazlVTTssde1tOvCfDR+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zz6qNIKltTmXoHlX1g+R7AWUOp4OUnndefvednj8JZw=;
 b=Q9Io7N7s1K3F4v6IgvimS9h5PjU1pvQ9FlAjydvYuNFj1sU21+RzcvvhIC/r+3+q22NRZ6dc3AaoyMlGz4+uQZu6kE7+CrEPU13+O+2WnWbjZGejG97REVUDJFNUhK4hcd+P9xiomTBbW2YE3tUQrypuHY+Iew2W74joQ3EynSXI5zfgVhoCvS46SqmbTvcQh8UaY70/3ybjin5xwfmM/yY/+ntEYf3scuWl5+kcdOFr+DggM8yU7EeajZC5TFK/JYIP6SwU37j0EYT6kxmZGjthlVP/mZLJNQYEyOxI+QdUJ5A4oJrpKC4q0WdekpF/lSMGHTqgqsmFsklPt6szPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zz6qNIKltTmXoHlX1g+R7AWUOp4OUnndefvednj8JZw=;
 b=bCqKYgR6fXEHRoS0NJ1WbVJTgNTj+qOoO/33bukAgcdT9m8N+2Qm4c9L4TSEhZqEl6G6Pzs7KQ70zDn5p20mtPh8HXrSkvuoefFN2giuQjYILIU0/IIUEJKI1UP8b/UNo4bViONJO+0BC4qS5qRQ5yCYKiFMrKSx4bFwc+Cv+2s=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6465.namprd10.prod.outlook.com (2603:10b6:930:63::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 20:48:11 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:11 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 06/16] maple_tree: use mas_store_gfp() in mas_erase()
Date: Tue, 18 Jun 2024 13:47:40 -0700
Message-ID: <20240618204750.79512-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:a03:338::7) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b636b10-6182-4595-490b-08dc8fd7f788
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1T9mGsxxKx0ljwTtLyNeniKZsg4pbbIkMSAu3ew+K1bColtmxtkLUr6eYsY+?=
 =?us-ascii?Q?wqPf5kB1RcRkMjN8SgKqkedq4PyVBBHRTg+0qFiK5OWNDHGDYL936Xjy6Z0j?=
 =?us-ascii?Q?fnF418CouJAncWq3+t/yMoUjefP9A/lOMwyeijkLFzsT3dpoTb1VEL+/sA9c?=
 =?us-ascii?Q?Uy8+LeBjGmnQ7dOk6ZWRwQGirDeur8/Nw7oyILt2Wwehslaw76qaYV3O3Wxe?=
 =?us-ascii?Q?f0qBftZ5NktwqJX9cHZzZr0WSMVUS0ldzYCQADcSZwya3RPhLUN5XHk1Yjf5?=
 =?us-ascii?Q?jGSTxjQdI2RLzP3Fd3z7eMEKlAcW7teN7RKVHBvDphplF9Lu6RToQoajJuTD?=
 =?us-ascii?Q?v6v6XTFU++FshgjvFPksExY7zdM4j/pPmtQntRQrlMI1wn8BU8Dt37XCvUHw?=
 =?us-ascii?Q?A138cmT4U5A6iCqJvXnt2N2w1amPcAD2T/SiVJjgx/iPJha6J4oYZmyG9KEO?=
 =?us-ascii?Q?daWLKlzjxIqFe+k6YL32VzHxbMBke30NrPA2LA1ND5/K6CVCpMwMsjE+284P?=
 =?us-ascii?Q?FXZlFxfc2qjloEfxZgY1TntymBoEzaOy0FqT3mUCqA7N4KB1yY868hxhnn5i?=
 =?us-ascii?Q?6HKI+7i8VEaJK8XPZXHAoL2QdcOk+D3ndDdysSgKCXJplB3rg66jXbXIdfGw?=
 =?us-ascii?Q?cGZ9cmINASqZKHOy+wKVf+zvW5vqMjl8/VJgaA7uSORnrdeuPYb5b8yvqa0B?=
 =?us-ascii?Q?HCwF4kEvawKgVFzb6yF7r0cXkjIQesKJ60YfaE4K9XZARfL2rg5nxJKPW4ZI?=
 =?us-ascii?Q?Y+X8686ZA2TRTImcYJi+EcMR9EVVxmrcb+MCzvRCamYz7VmyVbqNfOeRG3gj?=
 =?us-ascii?Q?2TmmrzhoqqlCwTcN/hCanfR+3GOjLN3pmDi6bPw1Pz38brQo0nXNWH/yRwdc?=
 =?us-ascii?Q?pTN8L59hD3oKB+iXAeOvcIh12+dHdCgBXWa9vD+ptJysRSk5uvpXs5r/Oyap?=
 =?us-ascii?Q?Ob+8RTNrAyiWDg/1i5W72/dyDfaIHEkfR99F4uwkXjLFfft8dbITm8DdfRQ5?=
 =?us-ascii?Q?li7MqaNDGLJULUzfWrO5Cju1ZnRDlG/jmGiM05LLlp5he+pK+cDvFcAJwq2n?=
 =?us-ascii?Q?+F15MWKXpLV9tYTxICXJqC/zxo0wNed9BP5Vk6dt0+nSMBW+Agfar4Hetv9h?=
 =?us-ascii?Q?D1R8mMrMB9KneBo8FylTgFFCaV6RGMZpKzG1NurCc9/QjwU/wakzWaXwZu6u?=
 =?us-ascii?Q?7KuKZiUaSAIYEAkpWCcj8FOgQTJoHN9t/agJd4mF6/bSMWKSFbYgcsh7O12z?=
 =?us-ascii?Q?dNJ+i720QCnSQoBjxCjqW24PrjrYkmYxt9eJwr0Odr770rR+E5m6LQfyt9Fo?=
 =?us-ascii?Q?/ZuA1hzuqfi8HghBVn09Bkci?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?b/8AI9x6f8bFmdw7sfyR3D4StMx/NiwrgceDGhFmG5fcwLEtkg5VCq9q2dHW?=
 =?us-ascii?Q?zKInXsEoq0yQXFhTMnRyrCV7qm8WogSWQZ8l6617TsQr2NKEU+vGiLEWGbJK?=
 =?us-ascii?Q?E0MnhewPA8CPzAv3LNFLH2LHgLprpaA7ce0FQ3/LEov/FKLDNFDMHlaxGNLw?=
 =?us-ascii?Q?SJcJSWaufTta7g79TqWA2wmj8vn5kFgypsmoRkyW+qGmVx3CgrdwJp3vTsyo?=
 =?us-ascii?Q?sVxrRooOAhQlboGhwGAdP7mEwgxJI+lE5jvCahcqlXVcGkcYbB/blY+9yjFp?=
 =?us-ascii?Q?SdikJAwaYrCUE0kl0MPhBKDOPR/OE08WiU+s3U1DS2y3sy5qWnfqF/PWJluD?=
 =?us-ascii?Q?foLlztyQIcRZwN5EVifAjKXfSNm6wfTGI72jnQclUEHc2Pxt0gOq4c8fsQlU?=
 =?us-ascii?Q?a2Mg4veLgU6u96acOWD99xjJbGMWy39NT2K9AbJSPv26AeNoR6k9+q7lWU/7?=
 =?us-ascii?Q?sRABNe7/Ko2YZ9lYgXYP6K7VR5lUT/y02UO5A4BzESayqulBsAiZ3vVhoD7J?=
 =?us-ascii?Q?EDN8lptdaZRSgeUBIBoebydsgoWU0Vi8FSBEMiwNGG52AcqK07PYBk+DiBFO?=
 =?us-ascii?Q?YQeuvw7XLRl2MUVQZKGrhAuFgZ+TT2a8BYqq/k38R5t4ZI9/Jr0SkAB2yt26?=
 =?us-ascii?Q?OiyJMk4jHT2g6rTxvh1Ukf9mgOAA52qqzR1fpSpr6nRjs78xgdjP2PNc0Odn?=
 =?us-ascii?Q?CEzeN3pZY+vdrHY6ocWnViV2cnB+Wd1n0CmKBFBbYJTqWoL/xlf+udpzMRhA?=
 =?us-ascii?Q?E7gj7/9NNzebML716WmfnMVPD/IHvQMv4+XovphBzOpI4RDxhxbThWYJOKu0?=
 =?us-ascii?Q?4P03DBFyxo90uQo9JrXWGGpuJ/TjLF60Bo97h2AvdKnBaA7xbIxdYZJNVbZN?=
 =?us-ascii?Q?IlAq/OW7Zmsnjz1p5M7rAyvRjH6hROKKo4wz7IwABBvXiVYXzra5nErYZ9cn?=
 =?us-ascii?Q?Zh9QRhOHimjcsSm9YjtCZLPY4vC1Z3ATgwTrVl/f/S5Osuhb8NPCbUDugvEq?=
 =?us-ascii?Q?OZmx4hR33gFNuPNX43V2hCnRh5rq3byoRenPPW8ekn6Ue4aPbry9nWl2wdXI?=
 =?us-ascii?Q?aX+xZq0nhbe8XrFOkv63DmXrRche3/jnQZaO7uZ+W2TJNQzuTAMSGn9p84rt?=
 =?us-ascii?Q?47Tq648VeiPh5MRD+nRr8CG0bVP47x21e2lXxoK6RR3agP31DiWog4PyEwJH?=
 =?us-ascii?Q?CD6CaGbyCY0+/VRBJPehnFyK7RN3i5vG4oOXPCuki3dDbaHggNij8WzPQhIQ?=
 =?us-ascii?Q?1idDCZPTcbppFkCaHV1vjZVunu8trMNBS1Jzhy24AuJK7yU7Lfzf8Rqn4swO?=
 =?us-ascii?Q?dDDJURZLIzwb3h/sBQRNQOEbv72qCh6zSjC1pU+pQD/J5wu1Dn4+OZC2wCNQ?=
 =?us-ascii?Q?lHpuM8gStbFINF7jBP3Ffmk7VFEhef0PvB1XGvOxF7Eyl67AlloaL9ZWHD81?=
 =?us-ascii?Q?Z5OCiG37OdJMjfTT7ZxhlM9g5DJwcvSH5fgQXptfto0pIP3PGYSC7eb2cIRO?=
 =?us-ascii?Q?mfuIpbT6HUH2CshVnGjSE0QG2odndgQtTcZIqP1+Ze8BO9W4V7hujB2eyvsg?=
 =?us-ascii?Q?EOlrDUrf2ZNKdR7ZroBAQI7fa563w5YHgn2Mu5KjiOWarV4DKBel3pexDhJ9?=
 =?us-ascii?Q?c+T+dXZsLtzZtiJnMIeCaAo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Yuv87YVzbQ9mVwC+QzN3b8S9rJqLpv+K4szIRNj8EFYfI3gd8Do6S4mUHk7HjF68OyOdfqO9DiHQ5yiUhZ+bUcYntzk1kImboXCPCIvpwszao3230TDJAsb/u3GEYKp21+7tPiBysGMnUJff0JJ/vu1pKc3q66RK54sUJAsyk7aut4u5U2Qkem0cSyp5uagy5Zyx+Rc41x615QyLs8C1DzrLxXwyC8yHNCF8g2JKNQnR/zGK1wrbXnsZu2KW5Abkk2OdVgYLB+rPzu7PJXK7lN6tWL8s4pNgb/UZLxzbXcEOnqKfShnzIklpwePkS28SeZJA7X5u8q7UPDORd2odAy/TOElq/g6uknmZKTveGxCwCUaY8irDjFCt58z705CwRPPNL3HOzQABHYgRRHTESS0vgerWs0lW+6y8biVrlMwlp4PkNW8yMf+Ez/VKCxDecRezPxocULY8kSUiFbz50H1VxzViPjUSq0M4qx3A/OVDhoJ27IB7ZaX9hjNktqHmLp4oa1prV2RNdd2PUNI6jLSeFjOSRli2gaeSjN0v4w7npLclagm+xTLgnN+DBsQFvpQEEPtHjCp19fBYIvhpNKaFtI8emjh4MPuwrIOehiY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b636b10-6182-4595-490b-08dc8fd7f788
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:11.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FE2Fm7oq+9SLTvy3zke/lHiOwjR1E8DmUb80rtwFm8k9+1fy+W4F09QbOR/lrx82oPToezA/VdFev4erzHH8DccFfQyNACNRQeTczust5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406180153
X-Proofpoint-ORIG-GUID: RSST5i-5mF5kriKklRVucoqOxjPGZMa4
X-Proofpoint-GUID: RSST5i-5mF5kriKklRVucoqOxjPGZMa4

Refactor mas_erase() to simply call mas_store_gfp() which will abstract
storing the null, memory allocation, and error handling.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 648cd003b99a..892e864d4c9f 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6352,7 +6352,6 @@ EXPORT_SYMBOL_GPL(mas_find_range_rev);
 void *mas_erase(struct ma_state *mas)
 {
 	void *entry;
-	MA_WR_STATE(wr_mas, mas, NULL);
 
 	if (!mas_is_active(mas) || !mas_is_start(mas))
 		mas->status = ma_start;
@@ -6362,15 +6361,9 @@ void *mas_erase(struct ma_state *mas)
 	if (!entry)
 		return NULL;
 
-write_retry:
 	/* Must reset to ensure spanning writes of last slot are detected */
 	mas_reset(mas);
-	mas_wr_store_setup(&wr_mas);
-	mas_wr_store_entry(&wr_mas);
-	if (mas_nomem(mas, GFP_KERNEL))
-		goto write_retry;
-
-	mas_destroy(mas);
+	mas_store_gfp(mas, NULL, GFP_KERNEL);
 	return entry;
 }
 EXPORT_SYMBOL_GPL(mas_erase);
-- 
2.45.2


