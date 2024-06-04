Return-Path: <linux-kernel+bounces-201187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C82E08FBABC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2501F223B1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F4914B95B;
	Tue,  4 Jun 2024 17:42:32 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A714B086
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522951; cv=fail; b=VAS5U7ndDLfLWs8LXHr9SNLUDNTkmeiltcTLIGM272uyXWneuiQ6bbalYlNfQNzeYPhUJPyuuILn14k8dRwrs3mVhMfB3xv2rRPm872uWyYjrMn3ggPvmEjDelAfiV7LutlijV2vE8sesxJOyEeURgKD7UKAS7JuCCs+vrfZNSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522951; c=relaxed/simple;
	bh=re8Bir2TAqFKpAzbQbuQQAWP5zC3HP8ghfkl0E4uGSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gk+yMZ2b19wbx53rNgjlufR01EDJzCr5ldiRoTnTjGUJbmgXNndyuQFgomlMiliXkTeccTwADPG4Gk5hipcsq4yHj5uBDFM0v1RiuQkq3APX9j3D+IlZusF0TVACHqyhC2HVU0qHuezSH9XeYs3lxDs6LZdpcTEDukogIA9wDng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BnIf1028071;
	Tue, 4 Jun 2024 17:42:16 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DqE3lKRhOHhotDxRjulc5YenacaU3n5Sw0mx2DUmpLno=3D;_b?=
 =?UTF-8?Q?=3DVQ+qVnQ/j7pW678Xd4fK6t0AJDRTOfrQd9/MjLSmD4I/HZ8OXNuM4cUGX+QE?=
 =?UTF-8?Q?E0H1mM1d_rXjHQIk+JW7eDrX+8jS5NfohFoqAw+yAfJs0sdToHnCfdfxMwK2eSn?=
 =?UTF-8?Q?/+jftn7Dzi/2Pd_yF/eI3MBaLgabC3/OQbtGshBUPJ2F8sqHb4kuSxN0o3rd7Se?=
 =?UTF-8?Q?isQ9d6Va0gVF/jc+OR9M_hpWJbqGUIi6QmHBshjFF5ZD57rWH1C37ZIV6xoytYy?=
 =?UTF-8?Q?g7H0dG7+lVXLNeFEslWFUjpjQy_5hC3KclEAQF+MoOjJmLfvGSDyVB1lIeVkwlm?=
 =?UTF-8?Q?zvXo1gfMCrnkUVRKhWPyyIzBOzSjnYmQ_VQ=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv58dj9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HNoQq025242;
	Tue, 4 Jun 2024 17:42:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrt8xx7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwMlPx8vqvqj+ydH3uPGrbCdjuihKo8X5sR5rsd6ZEbF2zu4IIg+sdmybegvMuT6/3KODPdrTll8io1jmjZ4zuuH3es0h8aVc4eqOf3LRQEIUR3EhzKzrYIhqIVqeF5m2nrn2uBrqY2Oxj7RJUqY+epd3jTj2nn56fwLWOGuqTG7B1rxvBCVJ9mLneVTegxuTq+oUAmFUJQWBCCrpbw4A3vWNvNKRnijGkQsg5stwnnKFVj8rTsb/meSfRR5zPWBHOyvQGDIEnIsn5sT5A9yXMysr1QXYpCydQ57M0XU8pWAF09S2KihE2GZMW4o/N+8PD3u+ZuO6lqhIB5MXuY70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qE3lKRhOHhotDxRjulc5YenacaU3n5Sw0mx2DUmpLno=;
 b=AODb+289ncSrKSzKIAqF1KcpE/C2kOM+qjrad6XaK2HG/ZLYKIEpnW3qgSUgxd3Dsw0ABDiiPSvIGZ3+jjuBgTLDbCNth6YW1tOtk32PsU+JVWcBnKbZNutkUhSjNB0+B03GaIZPrGSypj43y+gZ1TmPh9U6z75g5C5euSqY1pBKD+iMpgAweWhGy7RJ2IV+CoTtlaZaxOmEPVsAOqtymAUpflGeQwfPIlF4+WC7+mcfU9W63lEvuz8a8DqIfhK1uvjdQpzBq+l0BAvjm8c7lZZIRa2FsjIHxZAZj+jO96hGEggMxZuuWXtguhFAACCr7XSkxCjR5IhZ15PHmdqHJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qE3lKRhOHhotDxRjulc5YenacaU3n5Sw0mx2DUmpLno=;
 b=MNrhIruwvRBFz44zEE+YJVRij3EF2cx77wImL76CJsiebN+OX6qjrilyg55cVvGaiDqt1wv9YH8yxdfnh1BE7DDjtumRxeAPtAr0B3+Kp4gZq5Hk/Y2z4MpksH3Y5BiinIOSX7c7jIbhzwJ/qssIdjjmULq0ZOBE/3kkIPYI3eE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 17:42:11 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:11 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 09/18] maple_tree: use mas_store_gfp() in mtree_store_range()
Date: Tue,  4 Jun 2024 10:41:36 -0700
Message-ID: <20240604174145.563900-10-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::35) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 242bdf31-f1cd-4638-0e83-08dc84bda9e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IXzwxLq0YvFeuU6zZm2QzGuGqfiUlohmJzugPXs44LJHef9vuCHU2+BG2hIM?=
 =?us-ascii?Q?0zZLcqJTsvGeAxB2PEiMgF9eZvd04ZhzUQt6C4xurMRGlZcYhWa7UeEeBZtY?=
 =?us-ascii?Q?QVbf9vl6yklKQd1IiGNF6gkCcO8q3IK2TaMZ8+rleQ+iF0DTIOwL49rSFRX8?=
 =?us-ascii?Q?t+Vm7oK4E28LOboEllPHySww1i3JPPWBYOR9gbHCbgR1omCeb8sjnBJIooB3?=
 =?us-ascii?Q?oS2G6yiSgC1uGsaAOzslAHibZEHxM22j/2E4JMVJ9T2O8FBVsUvagu3HCyaf?=
 =?us-ascii?Q?/hr3tIoAPKtWUDjL8UHD6VnGQN8/CBHjp813Bpb6mbvE6tFRe1xKMHuTh0Y/?=
 =?us-ascii?Q?+Jy9Vx6QL/5Nzfg45fg1SOn3ObWCe/A/x8okbeYlLGlqKWI23gvnEBwqfJh9?=
 =?us-ascii?Q?Pt2X7TjMcmhOIa+ndJd3Fpowo7Ks/HKxODoIq9DBELcIDa3Vce2KKcrDYekD?=
 =?us-ascii?Q?zBvJafElWXS0gTiBNfor8v81rgzCIQWjvYep2Tycrxr8B7MXAKwje72gnYcj?=
 =?us-ascii?Q?m0xvhWsY/jRHsF3bDHASsmY60TjVOqVFpVgAWgoZ0uiirv1j0HbyNwnv6zeW?=
 =?us-ascii?Q?q5hNMLxuQmpYI7MUSWBMJ0Nq55pI3gLVyzzTvB9jzbGUXTFU+9jgDZqV8FzU?=
 =?us-ascii?Q?eQ2GudjpIRaaXBsqos/G/HAtMFeR3yyJu33NAOwJ9w2ZeznO+t7ms++7SP0Y?=
 =?us-ascii?Q?gBinc+SqVmgioUvRPlcKYA/sE60ItmjjU8cZZL+l4YgUvGN1Dmqz5jNK7OZT?=
 =?us-ascii?Q?xOsRd0L7hzpAEWiVvNeS9rajku7YpZAgReQbCtc6sm5AzkxaryKKjwVTBl+U?=
 =?us-ascii?Q?KVyXrMBJMytPb5K5F17MkDQ07AumPrk+Bo8sLNuOFxhZTZ2p3EHvauqW0dtJ?=
 =?us-ascii?Q?6XLlcxBjOWdlhR2ytVhpzAtAefOIswyLVkc+E4wiu6Qlt3OFSP9nir30EZvD?=
 =?us-ascii?Q?ZUqrRRvDuwqcZCFwIe/VEKNMOr3PjR6e9ZmEsKY2rqqQ5f73OQOcJfWsLCyy?=
 =?us-ascii?Q?TSp+fub3N6TmFkJv+4/wumPKEdBxAxa44LBbSVu0NIbvQUCZc7aRGg7dOYO3?=
 =?us-ascii?Q?EvitwsOlrEU5iAgl9puvfwNT9q/7B/ub08ElWSBSAi8FTR2YYWvOZkTY0n68?=
 =?us-ascii?Q?Zfaovrhuyx52rzbf8IDLsIJcJUMogCtWsSC79hU8hHPnQOT/zupYEdHBy70p?=
 =?us-ascii?Q?ql8hGP2zzRPvLNstGSyy6wifi/YRNGtaqJY3uZT+PIA88PnjLff7jRyv3MOO?=
 =?us-ascii?Q?4wn/cWcV3elwo50APf/vhVPDEK64JZK3jySuFVYy6SD0iyc77zkoX1mWNQSc?=
 =?us-ascii?Q?fmnDOcAA8C6hnuQV7CyB7+Hn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qz3gg/tYo3HyH3+xeMOp5zOQcwC9eOeaJBrnbV9cd1DvXn+BChSK3ENUV7va?=
 =?us-ascii?Q?fSVmci91UgS+UXXB68SbRAD620Yj80bIqkqeTxKDIoDbYa+pa/lPvqH/bl2+?=
 =?us-ascii?Q?r1DMRZM1yw8VKlH2SCXzkU22G5kmWKthqHV7ik9UGCZ8gG3otmGofqpv1rep?=
 =?us-ascii?Q?QME+f/vCV5geXU5rPwLutJzF47l1P8+R/GPTe+nht6mQ38jRyDy3g5MW3UaF?=
 =?us-ascii?Q?D8pRKFhf3AlqTKIzz3hzfM1Fe7aySi9ZlvnJX4GRbU2HPcdDB892o+wRTTN7?=
 =?us-ascii?Q?6LIN5irhbqnw1nGZjq7hYl1kGlug8rQNfFCW3LIUQK2Oh2dLcx5zr8rlS+it?=
 =?us-ascii?Q?0R0LtUBJDB1ri6Pdii8JJC1M0EmczwhjPUgBdHswGljycJm+NCG7OZDekVrV?=
 =?us-ascii?Q?1zKXso8abhMOMW6F2UVzrgboeR4V0bh48kUNj9iblOHShF6U75OE9PrI0Wkk?=
 =?us-ascii?Q?dRz+B8zSvVpFbCz7A2kJtQBSXwfODI66aa9+82I0Te1DX1g7k6g5www1JUwd?=
 =?us-ascii?Q?51XrFYk2QXzbzN71zn1mPXrgeoq7GgT1//nGu27u9B7FzMFDfDH4Ka4IGtSV?=
 =?us-ascii?Q?iT1M9gVi/SbIwbTkM38AgOwgr75b3mkCm89PQcfxJlvAhJag3gSXclTV31DX?=
 =?us-ascii?Q?1GGb/V68zunycSbFM944SeLFkoD4J61gjjm5MTVFuwVFQyPMTopuMaY0YlmI?=
 =?us-ascii?Q?rHt4tJvISN/b5RxE3qiD8McegrRuTDYD1sbGyb7LreAuqhnP9oMYla/sdmUD?=
 =?us-ascii?Q?vW2mkBAt2x+9vHifW7kovlQS5YSeAgnYKYmoJJbUPMI6bvi1Y7ThWqR8p3A8?=
 =?us-ascii?Q?H65yrioM1D02fKUVZTJY5JIwCXfHYGRnIC0EOMbL6RnmY0BH92C0dTLLkFD3?=
 =?us-ascii?Q?OmYJHwIThnPjt+wt1Ezull0s/qzNd1IGN0cltc02xDonH+zMhxQCoeNKlvU9?=
 =?us-ascii?Q?JGxnNZg+OutC7+rIocn6iyjMkIvl5fk4ajyxVFDUM9cGsUmwUvqseBCgkyrT?=
 =?us-ascii?Q?PrLJnynTJ2a0Zyt/qJtHW51No2P8pdFYsz6iDYeOz2Ndxukk8qJXoWO2gno1?=
 =?us-ascii?Q?AB+KldvwzPzeSEQHOdNSBvTCLSVmKGPwYCQrP6Jp0J4sDC3PEJEH7+5DqJyX?=
 =?us-ascii?Q?XXC4WVSdzlxJyK511NvqlWP2q3cE3KfZAUpO/a0/yJuvShcoWL8pF0ElvQbR?=
 =?us-ascii?Q?wehrd4elkbzRyvHdgTFKxU8nXHuOZglVaiQyHDj0bNR70q0fZTKSVNwT2qP+?=
 =?us-ascii?Q?QucEl7zJCr5G4AxBqn/+EjfZulUN7UHTrIFrhp9glg9AOEMsxWbWi5IysKot?=
 =?us-ascii?Q?aRJT9QF7juZDK3gG2kSHT9+haY0TiJMbF/tojcCmz09lQbYVAOjuLpZixoea?=
 =?us-ascii?Q?CExoHmIGZAOrhuMFbDyFwbcFPxOpamP0hGJQX23GsScOdSRGNn9Q9pPrmLah?=
 =?us-ascii?Q?4Ur50Kb6kKBkalrVYNKUqioyrDYLq3als0PA0Rn00Hr6cdOzys7lVt6YXBF+?=
 =?us-ascii?Q?P2EPYOlbXoHpUVlinaG0kJ9WrSXhAI2vzRXwlHknlXIr+iAwLjzbjqeJUOAa?=
 =?us-ascii?Q?Io8vlhjhj6ZQkM2FDaT+OuZQyby/iDj0Jy3HI5fj/+inr4OB3Zu3ALhlMC1h?=
 =?us-ascii?Q?whGNXrt3Ny+2bnCpd+DJK/A=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1BqzvqVH1AJn7nLZK26jIvq2Ajz6XTYh/bX2MwYMJAORQM+pIq0JY5uISAcmzFdloLxdJA9T+Turo0FOh/Jn9k82jtiAgHziYY7p+H+0H55Yim1v+dlXoutP6F8jaB4PKLovwpgpaCvIEvs0hogaQjR7Zgjjs2lJw+HQB8HsvGm9w6X6i3l9RTDItcD7a3pAh9/gYlaWneHKCgr2tKaW8OU43oyGS86LzZPxCjZNSae443/uHfSghda4KSMBesYvV2C7AiTp/bFW8WYjObpqZLhMBtrWRvG1nWFo0I/kxdfTLfPLQSoO9CDZZAmxRCGT2AVXoPAgBU+kB9bSJXCjkqzUEVepwrcakeZBsOCktjG5JwyEZG23an06nDsqbXsrJKOIuf6Uzgx50yLnWRgH0UQGe7EoIJVnBS3iUxg7RN/u7AvDsz/4p8K10HOVS6zyf9rRYEpaqilsoDuScnXS8reWcuAXa6obY5iUACwReiMnADc/MSLtNDzQBfos8MEO8QfWEw/wUjhpAl7Rz1FpToOsGB6SldYFiucH9WBkZmhsztgV5L5iHkvBnb2z0Af9RZLdd5zfyC2j95ULqouDrhKJJJpn76oyYHTSz2giUZQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242bdf31-f1cd-4638-0e83-08dc84bda9e5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:11.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwM1NUKD8GvnhIWhG9hdh4iTki9PWtMFIiZxDJn5hiV4ITbbhdiXjiYoYwmPdmsQg5AcPAKNMas7EY1J6wuZyZpKxTmPzbCaQa6WQtmj1DQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-ORIG-GUID: fpFyMsYOsUmCGYh3QBXmq5tmS-FwDlOW
X-Proofpoint-GUID: fpFyMsYOsUmCGYh3QBXmq5tmS-FwDlOW

Refactor mtree_store_range() to use mas_store_gfp() which will abstract
the store, memory allocation, and error handling.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 34ff1b3f729c..e3ec6649f7da 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6457,7 +6457,6 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 		unsigned long last, void *entry, gfp_t gfp)
 {
 	MA_STATE(mas, mt, index, last);
-	MA_WR_STATE(wr_mas, &mas, entry);
 	int ret = 0;
 
 	trace_ma_write(__func__, &mas, 0, entry);
@@ -6468,17 +6467,10 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 		return -EINVAL;
 
 	mtree_lock(mt);
-retry:
-	mas_wr_store_entry(&wr_mas);
-	if (mas_nomem(&mas, gfp))
-		goto retry;
-
+	ret = mas_store_gfp(&mas, entry, gfp);
 	mtree_unlock(mt);
 
-	if (mas_is_err(&mas))
-		ret = xa_err(mas.node);
-
-	mas_destroy(&mas);
+	MT_BUG_ON(mas.tree, mas.store_type == wr_invalid);
 	return ret;
 }
 EXPORT_SYMBOL(mtree_store_range);
-- 
2.45.1


