Return-Path: <linux-kernel+bounces-201181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C148FBAB5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F1A28832A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD95914A4F3;
	Tue,  4 Jun 2024 17:42:26 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722AB14A0BD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522946; cv=fail; b=jhpWLhCJUMsRa0tuEa2RtbVzmBq86Tv/aIO9gQ/SsH9ZxXt079b7TVGKMVoxOZyluYcm8RU9bbL78lnFKZVVducJoZvXqOFLwx33JVjvY84dRzo3xwlIJtAufk0EigHYDzKgG2x+C44dWxs9apJWZ3RmBL4Q9qyQ71OhqBnnl58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522946; c=relaxed/simple;
	bh=K8jSRp+bYXzeK8tlxbNNrxeSl4ZXh/6Ruj5M8cyfWIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W9yBVYqnN4zk5wQq9b9dZWjeWO9AO5ZCkpSgDiESPjTiX0XwxJGbgVp8R1ZuSg0RWfUm6xkaXy36dKMlK04i5lWM+waBGoA3W2/VCozOVntLyksIGVkQN3UtRaybLAgFwHKZ0HxYHRd+qZQPq340TuqHZKkS7DONhZ30qdnUqug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Bnw2E024630;
	Tue, 4 Jun 2024 17:42:02 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DD2Ttdv4jO/M0NZvyd6x11j417E8vjm6zIIzfz5tzgbI=3D;_b?=
 =?UTF-8?Q?=3DLaXKDs2Giq9Yuc54as2jVLDEDupf9e/TZPD5XbNIm/1HoTOSyGiQGLLHz5J/?=
 =?UTF-8?Q?KVDnymwS_YNFJbepAWHnV441MCr4orQWnbNMfdb5Q1eQPONXzmJjF7JnW5WQ0r+?=
 =?UTF-8?Q?srbgcZhKiriLUk_NAfuNQsQml6KRM0qY6rI0fMN1vk4Q2m7wEql4XHDd7B0gRo9?=
 =?UTF-8?Q?hwVuV5urBVd1nbvhBiVX_C12O6mXr7ORBZ2HpdQo/IWeFE+xmbHDA/2qQwCFo4z?=
 =?UTF-8?Q?eD/8A+Uz69E+yoxzhoVsFLN4zX_xYOM1xB5vWSGgHFnmo2QjdZN6wicqgKCIwlA?=
 =?UTF-8?Q?PwOn3nPquxeSbDdUvDERiouWFhVVEXc9_sQ=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv3nwhwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HAhWd016185;
	Tue, 4 Jun 2024 17:41:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrsaf2q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:41:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMkfEYE1dVmdukxOxeJpBxKntOgXm36vdKJG1Z65mWrS1jNts1+f2qRgkUE0YK+18m+XqpUYxN4h2iQHjeAzB7yuTyet2pNZBt+I3mnUvSaE1N57hdFFGl4J3KgwEoPewdQN5JanfoBNAd/JBWrLvcnpO1xpwSrHbQgp7+IOQlNe4YH9xFkhGQlTgJj3ATtLsVsSYk7lSTMUp2V9YNzw8LZXlErRDy8YpIGPe/9Kv+cLJQuDqHWuO/B6P78vi4FqcrATLoGkUK3bgpFDeXkUUBXamNU9hrzoKTjur4MIRcTRqa8VAZUBf4t+zWYBKr3YiwczNU/3BCGQbmJfCiNOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2Ttdv4jO/M0NZvyd6x11j417E8vjm6zIIzfz5tzgbI=;
 b=VcAzZimpBVO5OEOJAou8uGkEDPI7apVmiIGl0KJDVq+/euHB0o5+3qghpty1U7fGtsJ6u40PbKqueq8FJu8RYS5JRu/tcSwQsO6XKRaz8rn7UUw1NIRQGh6Otf+wDeRjnJSAbHVsDquk4Jq7ADw+4E1G87+RZ4jdjs1PbuD/7Hty+H1cuYXRHlnDCvBKr9NMYwfdCvwH7JngW4ynXUCqz17Z+ObRmFI4AheE5ATzLvS3aMKmD1NIItNwauyWgi9iWGVBQrl84236cyfKW9539GPwbdpN+VBW41q4uUpmbjNl/HYts0+o+j/j/HEwc92hUxt4A3TvPdfqn+3flqFPUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2Ttdv4jO/M0NZvyd6x11j417E8vjm6zIIzfz5tzgbI=;
 b=w7O+KYjZKmU9BOtLQ6aE67KqLjJEHv9OQZBTR6zcxCF+EL8DfS8m5JxRq8Yp0KkMBDtGGdB/Q+9CcHp6vMz3FyloxJ62/10GId6fyxEvWGR2uJOReV1JjBOhUwhYBkMkPqOVKaPXcKULCG5PR2mrUVrrD9Y/zPN2z65KzXrMJb4=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DS0PR10MB7269.namprd10.prod.outlook.com (2603:10b6:8:f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Tue, 4 Jun
 2024 17:41:56 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:41:56 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 01/18] maple_tree: introduce store_type enum
Date: Tue,  4 Jun 2024 10:41:28 -0700
Message-ID: <20240604174145.563900-2-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::37) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DS0PR10MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 73949498-f61c-4c93-d49d-08dc84bda0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DOh0i3nkhKHNXBwirOQlS2weKyPNNHxgKECB0ZP5WoPgZsq83ftclstqtOSX?=
 =?us-ascii?Q?ZxPGdgyFH0ul1PzJriGw/ZOHiAVz9HiWV5GuPtLzb9e5LKqdWAz+cjBuBYo/?=
 =?us-ascii?Q?+43KGwr8PjSOjdHDzCUD4YcGSD1OfYu+WX9AgWfmZS/0jBkzNeEJNkkQsEs9?=
 =?us-ascii?Q?GYtX3dr4ES2SxjG4tyaWc15KQf9mz7Y1gPCco1SUCAP/7gp+XBzpgeZ9bsR6?=
 =?us-ascii?Q?nsxbKRARPeXJ6ajdMXIgwPUKDBZ0ac2D9gKGnR7tcNQ34oIgUBUrNYWfp++u?=
 =?us-ascii?Q?gaw1rJRp1l/z7UX9rBBNo0PPOBCP3547lQa7BJa9WksJaYPW1bn+QfA3IJY0?=
 =?us-ascii?Q?ArJ0cvGr1p+RgsNNV03QxTDbEPkf4KzwAJjq+TNftu1aVm3H57JSq7qVhZkQ?=
 =?us-ascii?Q?Js7w3rt6b1PbYjDGdWSc4KG1SJnIe3bjbwmP34y4H84micMwETrCaW7broJZ?=
 =?us-ascii?Q?Uju1dgapLH/WotfZmEcIesTv7kaz+g5QgbbL5RG1LdWIBKdFoThs2srtZo6w?=
 =?us-ascii?Q?Mox4HO/t3K3bH8rmU/1Ljcwl2IJJk69lrYpXja05jTN/7YITNfDHRyX8o8t8?=
 =?us-ascii?Q?vqBofwWzDxO/b7R3X3WgPhYjdzcFJAdQoLmS0vV7utpjm3U0VWS74/JUCGMA?=
 =?us-ascii?Q?PlInVePvDbXJdq7RHVvc/NHSPp0f7EANdITmQjplAXwDMNGcEjxc0QXpNniT?=
 =?us-ascii?Q?WiMrQeMP11ILCJ+R8OmIjthVapXVS7Yta/V+A8CWL+KpEWXz1Kl7MjitwEy0?=
 =?us-ascii?Q?FMiy6Ucjg6wc1mz7b8H2guhzavDr5v6HS505+mUkQtTFmSGZ3CyDepe5SN6N?=
 =?us-ascii?Q?RpW+zNl4Zo7UpetjdWASxiiORKUe45v9yn1ED0QmSzRIS6pmuEqiXhKNtvne?=
 =?us-ascii?Q?78M3FT6GAwdpIhKX8Zkn1VXsMnYAeHwoS+fM7hzHioHpzCMGe+jeDjtbBaJD?=
 =?us-ascii?Q?6gR8lZ0/ouXMCFAswJInpbgX4FB6nZCcDSP/yphXAP0LtgYZK5+/YDA5P4xZ?=
 =?us-ascii?Q?e9Zli3A13+Zu67tgm0Wf4RhDGfiRwHkgTxZnl6ZJqji3A43Ujp+XIODjkupn?=
 =?us-ascii?Q?KfJwprf2ePkJqaEVjdb/tej2e9kiQgHS1YRHtGUG89KGVFS4fZMIATEgqAKS?=
 =?us-ascii?Q?zzPFjzN2YSG2+0kWXhHyTMVugTmew8ZuX5XZzOdCbmSRZgTa2pZ1WQFD1rTk?=
 =?us-ascii?Q?bX9rCT3+vZn0dAkXvAYAMGDABPFnfEi0+z4Hj0W6v5h+f68SWhhS+57aWwN5?=
 =?us-ascii?Q?kvJs6tbJ5favp0dgHeVaa8ApP37vluTd4VIzX7w+zV5n+hz9dIWFcxN07c8D?=
 =?us-ascii?Q?4op9dbBURNFXR0SvYraixLqX?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mfEgvLeG/1oPtY+xqD6EAimGt02rAaprEZN0BdHjrgfTd1a/pkJJ96i3wenS?=
 =?us-ascii?Q?T7nXEdtz3sb35ZKGzhZb3mQqrQzyDHEh6vpKCtSFNuNrm9j6XCad7iIGW5DT?=
 =?us-ascii?Q?2YTDqBbld/zFqULMxxbdT++YBqgWH0bx04RmPPlLR2P1NfvRa2nd0/QJhM3t?=
 =?us-ascii?Q?MODVil756UPAZ6ZpB8heiR36UYth513CeFPiWxUFUr+Ui+ctTyckTfdkSmt0?=
 =?us-ascii?Q?UmCr5HuwMGEJ5DRK+/Worn6e8tN/6GHVRGdLDieODbYTcwJBJkzLYFzBAG+T?=
 =?us-ascii?Q?tJbd5J3RrkXEH0DaeqICKE6DiZXqW/Q3D5wVI73+Wgki/5uxj5SQAlUV+I2a?=
 =?us-ascii?Q?quL6blNOMN4DF2l5sJ9Lpmg4FCSBGg4TkWw0Hyd8rNaD+ViYx3b0OIne98nK?=
 =?us-ascii?Q?E689oAJIBBQdXrmNFXQOgeagi5j5eHLW6yMx2Yo/94V3g1g7cu2/nzetIFY2?=
 =?us-ascii?Q?IXt0M3u6vGPJ1HwlRw+ALwz02USJwLNazXUKaDnyx0yl0HHdeKPH6pLDHbPn?=
 =?us-ascii?Q?cGf0TCmShsc+N4G2bmcZF+6EFyjGo2eQWzUSJCm21v0BS9/7IsZ0ZKArFHO/?=
 =?us-ascii?Q?IMPjAf3Xp3qFfYmP/TM+EoeGcGYh33NUXAMU54Xy7+3A4RzrQxiDwmKG8jSS?=
 =?us-ascii?Q?NtAdfhN2B0fNpvjvYuiB7m0vf8AUIDQNHDY3ypgmUFkS5w6AUSAVVdn28aH0?=
 =?us-ascii?Q?Vs9qNV+hhNanTrfpoHG9fzbP45LVKduUzPiwOg6y2eYcM6niq8TK+4qxPVzE?=
 =?us-ascii?Q?0G7uLlu5MRuIL+3WfL3YDo9TG/sgfXTFk797L/yAjgPu1GhqhKMWCHAOhT7H?=
 =?us-ascii?Q?gFkJ2WXhToA9B6YiiofLj11A40y1ApeRQ+6lRwIU5K2g+GS0ne0aHNb2M85K?=
 =?us-ascii?Q?I0w5B6ACao5jA1M2s/uy4u+KUy3BQ208K2OMT02+sClpRhPb/i1stgBMGl7A?=
 =?us-ascii?Q?KjhVCn5rg/v4UxFWTHs+YarLzgsA2bAWY2LUDdRAZPtyWxObwjFBC3h5BPGM?=
 =?us-ascii?Q?645aT3bKRIHVgjSZ/K77qXO4XoKm/rVxCVNTFCjD3z2JwHmvM0Q7inNWDzEg?=
 =?us-ascii?Q?TWdfWZ887b0ca/ioaDudXkCHP+fIWacI2cevR0eEje3fA2qaYkT/fF4CwW7T?=
 =?us-ascii?Q?myli35YECLU9KxU3y4YaYF7Jf1nMzw79N4visAV1p9LQoHzOXQXGYYWm7Qh9?=
 =?us-ascii?Q?DeRJd7pD6XwwkDk0Lgg7Ci56jU3h2Gj3d9ZycLL+EeNk5kamqNNmsHxEYf+4?=
 =?us-ascii?Q?sbOSFSTObSXbpHosXUkSPvEiYCe9PTOZfCdOQ1Ady0BOAm80AxEpKpfrT/1z?=
 =?us-ascii?Q?uib7lkq1s85BY2QQ3C+6ybiVXu9wak+LkTz7I427DmQaLQNn5jEDFP280mS5?=
 =?us-ascii?Q?jRZe+LXlym4Me5XQIyNyeGRqZK6vimtM1gdcWuK8/3dXSHfeKJDAF/7NWBSA?=
 =?us-ascii?Q?890o0GTN1J26PDlM+DVPAuoL3MpbxYulYj9Z8of1DO3z196ESojipEoy3e+v?=
 =?us-ascii?Q?ZmWUV7a23fXCst9q928eO73tF/CLqoLn7zdKbTBj9csCyNXPyMojfkMHM5wC?=
 =?us-ascii?Q?Vb5aRlKs+rWEdUvM3JtjXD9G3mrjoUAVImldN4wZbikVK2GsP5IBSzgTrTKs?=
 =?us-ascii?Q?ROSIuuGprLneViz+slLNIVg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	UZX1VP1sHP22WiCgfsZW7EWDveHV64WGyfyjMuZEKGZTqY7UThYmefIVj52C2Ou6/N9XfW93qUMGolb1cwlfhWR6dnVNX9Jj7CgdyDlw80vhsQudJ2u+fJwwBDIO/T72Dgkz6oQpeNUN23MjAoxCrQHZDEpfXfJQ5Hip0M1nknwhgftcZ3ePh7//4I0uNgi6J7jecIY6Bhp81fZZYwV9yhbIPItYkiEfV0e5SxTu5scyNo94NMqyPXcg1hpp1BcuZ+lGDaib5p2/V8hjSiJOAGHeMZxLXnqQjBnBneFBVt4mFHx+bHviHbJ2b+EHbvPm1ReagAI9Mvv/j3H8fC3CyKIESY/KY5B1O2U9OLfSAvajFPeZzDd0zij/8qdkUj7wl1PKjQCsmiDC6hU6WuropS1Yygk0kRqptQbrgjMCZYGmylrZMhCm8NWBU+xQ3JzTdKY2wh6leEFBBckWtS7e3YHMCx6YbUdwnNiEhofgVxYX5KECsWCZcIme025fDvjjtrZqchdg0Bwhug3adsL0YdlkDaeFb5J/vT2gEvrKEqjceMctcSWZenTw4FXcRpZomgklyLm9IvRXPPSMmHU8McR2uSeKdR3Q80/PtcZXx+k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73949498-f61c-4c93-d49d-08dc84bda0f2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:41:56.5411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fW4a8/G3qg/B8UPQi9+8g6yfvdFPuIRlwlEuTq+B0cBnL2hBn2PTKhcG3NbEtt8G+o0+EJ7V0L5NheVIf8IlA7zYcSP40NRUeb5jzfMnss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7269
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-ORIG-GUID: sGOGTHmQ6zz-9d67wTFsxTze1WxafwcJ
X-Proofpoint-GUID: sGOGTHmQ6zz-9d67wTFsxTze1WxafwcJ

Add a store_type enum that is stored in ma_state. This will be used to
keep track of partial walks of the tree so that subsequent walks can
pick up where a previous walk left off.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 include/linux/maple_tree.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index a53ad4dabd7e..2a2abda9eb32 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -148,6 +148,19 @@ enum maple_type {
 	maple_arange_64,
 };
 
+enum store_type {
+	wr_invalid,
+	wr_new_root,
+	wr_store_root,
+	wr_exact_fit,
+	wr_spanning_store,
+	wr_split_store,
+	wr_rebalance,
+	wr_append,
+	wr_node_store,
+	wr_slot_store,
+	wr_bnode
+};
 
 /**
  * DOC: Maple tree flags
@@ -436,6 +449,7 @@ struct ma_state {
 	unsigned char offset;
 	unsigned char mas_flags;
 	unsigned char end;		/* The end of the node */
+	enum store_type store_type;	/* The type of store needed for this operation */
 };
 
 struct ma_wr_state {
@@ -477,6 +491,7 @@ struct ma_wr_state {
 		.max = ULONG_MAX,					\
 		.alloc = NULL,						\
 		.mas_flags = 0,						\
+		.store_type = wr_invalid,				\
 	}
 
 #define MA_WR_STATE(name, ma_state, wr_entry)				\
-- 
2.45.1


