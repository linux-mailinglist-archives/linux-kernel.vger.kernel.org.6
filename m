Return-Path: <linux-kernel+bounces-201188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1523A8FBABE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4B22867C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F169114BF8B;
	Tue,  4 Jun 2024 17:42:33 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FA614B940
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522953; cv=fail; b=Vq4KyyMDH3BIRzuBUoev4PRwEae/gTw4dl/oRILfJBp/heoVG4neD8Xry2MKcyh/WOj3r32bub1WhHfE8yVurJUA8Ny7icBfHuCItDm2gUnxmOTpe6U5hcs9I4+6CA3/xT451Ne8BaXhW81j4P48C0CfewLNryetg7bPSMslCu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522953; c=relaxed/simple;
	bh=3rwQ88qFQ7sPUoDkfB2jQ9DXm+k4GM7TxMwLQc86tms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ov7Isi5uVZ3f5V94ATQtzXUVyvw8bsndgMEf8t+fvn5Z5mFgLVgglIH5oP0o6UL44voOAwi3ArUXCcNOrZSnybsldyPr7L5sWYw5mv4wVOYRZWISvGb2Zl56Rx+UjC3RVnCAdndWuOsTcwdAsv0nT8W/zQB6YnGHrlitXi2ROdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BnSP1026512;
	Tue, 4 Jun 2024 17:42:13 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DeFU5J8MB6LX0FTsp6LFmCb5nYDKq0rtoXYUM8NbzpBY=3D;_b?=
 =?UTF-8?Q?=3DXTwsaOFmZMHeQS3dWlzkj/cxsV9+STQZ/Il88RiDn6LuqRjkyKXt6J09CNVi?=
 =?UTF-8?Q?WyMH3OY6_XymYCidPs4r7+dQDbbxa/1ADpzt7eKJrtFsnqRSGQHP6PRV2FYLLms?=
 =?UTF-8?Q?o7OyGrdQQ4AY/e_Dg11nAVp5fVfE1rvqyKUecPqqKDk35yr8AanQ2uh0GIMtXKi?=
 =?UTF-8?Q?inrZUjb5ugF6PjCQy79W_nZZA/UzYpS98Ncc30J7fASCLB5PTLCcyp6qIF0LX/c?=
 =?UTF-8?Q?yUAP/Qd1ep6RDyJkGk//6diu7s_KM8YBs0RtsIk1oE5qRCiGjzIKdvOHuWSOJv/?=
 =?UTF-8?Q?1GquiBhkA+tvOBuhxu3I31Nkqwsc6lP7_wg=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv07wjxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HPTRo005496;
	Tue, 4 Jun 2024 17:42:12 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmdwn4u-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfAcbnZVtej7HG6eQwxARfw7w/8uKVkLuYhGL2XKimAPMgh+dOomwsdgr4n543J5R64it14duSaNh+JwX7FC3FkjbO2WHgeHq40x83HYIh38G2wI7HQgVIq8jW7BRpcwqyeYkSR6LwE2IIl893ABHj3wEi3/9kiDdth2v6ToGrMiSw4YPUGJB4OgiFPQW+TBJIV4f51gN38y41hQ6RZaLLw5caB+3oF13vGE28aAfBOik+S+pPPOU/FUpcmYgctvXUgxYOc/o36FTa+LdZpjfymJAZK7MVe5cMFJyBT8gx9858qm2uw+R/l7tjL+iJOtg0HgywCOHPxFMMf3yrkdbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFU5J8MB6LX0FTsp6LFmCb5nYDKq0rtoXYUM8NbzpBY=;
 b=F44uLQhFhmCXFXK1kge+P9GUtR/PoywlWru68zCz2KYB+13QATkSGHIXmNo+wbxwj6KimOXHsa8EDgrpAyuveFXM7o3U2q8W37aI7ddkTSOmmQ/tWwpTPPO4eBHhdeBfHZ6PRdmXD/BZure+Ta87wcSXrnTMYCWFAkWXrH8BLQ9qNoqfMQJBSxpU8VjirQJDc8prv5ajQrxl/0I4iTIgA1qvfxhlymubPYMvq0qtmdmeNZpXq5G/YCUfM7qMi+yHYgswu4ire0HJJauaKuxzOpHJ4ucbWke9bdXYQZoG+K+dNUezfIlVdA7DCwNKk8ZZdOk3u6bE/aeREnp2lGN+NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFU5J8MB6LX0FTsp6LFmCb5nYDKq0rtoXYUM8NbzpBY=;
 b=mp9UkpSx2nVGRLa2SXNXdPki5h+VYc/x2p0IDZC3JFRv6TjfE4L1RBplCubmXX0GJQoWtSrC5sfRppgrNovqyiSLiCdXlGRn6dt1v2LBHt+y7WW3Vm/r1s7q++1Mt50Q8XjOwSNu2EKMaFvFCeP/7dtYyPSKF8A5xHpnj2QzJag=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Tue, 4 Jun
 2024 17:42:10 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:09 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 08/18] maple_tree: set write store type in mas_store()
Date: Tue,  4 Jun 2024 10:41:35 -0700
Message-ID: <20240604174145.563900-9-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:180::41) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH0PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8e8304-49c3-4f30-1ef5-08dc84bda8cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?j4wOM3u3oW5uDgSWakgQ1RYE5W0217QEMgfYp+lm9+FvMXJeTsM5Vm5CBYQw?=
 =?us-ascii?Q?byDkYe9hRdtl4hLxT+aADMh8frBR0Y5epWVbOzK0sZr4ZvLJgkpp4y/gzAFI?=
 =?us-ascii?Q?aSkDETwtzQz2iasr95X+fLi9xvqV32MGzdDrivtEcZpNwXXVGzIWw1+gArm8?=
 =?us-ascii?Q?OiY/a3sW4d4zNhrSiuW5rLoYxWH9tEr7R5nDTu0dnf5zQIytUjwSIOBKKmcB?=
 =?us-ascii?Q?cmrAyDlhnfZ6Ex9lpoTH8xPMyb6WztIhtBjCezgrPUnNU0AvwxUO5lWyVgEJ?=
 =?us-ascii?Q?JRiuVXdaVtVBvY+BgyUTttuajvSE8zRwdbQ9gsQLPBayqbD8E1d3gJvhL5To?=
 =?us-ascii?Q?2+RTIApROymawDB+T3Yu1wMBiWOA2rKFrOOcJ0zIKcfOey6xcjvrrKnER8lX?=
 =?us-ascii?Q?/sZJTXm2FF/Z1YK8OcLah1+jQ1cVVB3D+GseugugNbsahG3aVcNHT/IFgvdR?=
 =?us-ascii?Q?W789jPpHvarE5yz5fXhr3K6yEiH1Y6uVw8lzRPLcws5ux0zUpMFNJ62RMc+r?=
 =?us-ascii?Q?lEPsG2HpegWRMvoVxzrCwn9WPj31Zkc73zMu3XpE8VXcYz28DGTCedwg/jf8?=
 =?us-ascii?Q?0ibPhlfUU77vDWrJWIIDm7CFiyv6k0rkH9in1GFWOPJ+WTw3++QR1Xnu1d7v?=
 =?us-ascii?Q?LxTL4PBF3diS5ctdmrd1DWJL5BFLvn5HOwAIHadZsfz/plhhknjD3+fvm1wn?=
 =?us-ascii?Q?C6peH199vyaGiQHqv4RWvM/KkeI/uSeG9hgMybVlVPEUhWVl9VuH1GMAy9XH?=
 =?us-ascii?Q?xt0X7r4bkyI9o6F+SQEOzeLUdPYyEXQCZdVgeRRddg7LjyLvDOpVv83jGFb1?=
 =?us-ascii?Q?/OrBwjbllhBvSw0CX+Y60DgeCtBdw6unVJxf1h8ckIkwnZK+BnEqTzgrF7sX?=
 =?us-ascii?Q?WXPlFxrcpC8EWWzzpAqSKVys4K013Rc6yexZyLjEI5ZDAQFdNoc6Ccu4LSXH?=
 =?us-ascii?Q?LWkZQCXLuwU8IR+M2KrjddsGGM1uidxepdPwEKAbCHKpSVubzO7BZr3VOE9O?=
 =?us-ascii?Q?5ue1S26x+kQunw2YaPZCj2TS8kT00maevCuShAIlBgUyhcMEf7KiyZWnUkGa?=
 =?us-ascii?Q?FSkD5i1SOf/PrO9jKimguqub05eja8AY/wLUwcWLavPzJs1xmPvVGTzGe7mh?=
 =?us-ascii?Q?cxaoDl75fWTDPe3FwbhT7w0cEI4Gq06/2TXoBlIky23uCL4jULXDcR/zZqiz?=
 =?us-ascii?Q?ux7flsqj9pk0i3WC6j3x7Jv7BZ2udvNUj4JOMSH2A+RKL2eTN+k3qquqH0AS?=
 =?us-ascii?Q?KAWlPykMTb+s7XHl1sT/RdQaoXyUIoU15kbDwYrubW/2yg08Zq6Be8W3jLz8?=
 =?us-ascii?Q?1hkT39qNnRAShNCX79CFGEld?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?g7RLOpie6ar/sHnxs+M+dlKmWSFXffO3+h/Kyq0q8iv7XcAIrWtoB/S9Vbz7?=
 =?us-ascii?Q?CP888UbV0NfzuFAqEpwkGtdfPvXSial1NcJMBp06c3JhcmMb1KZcXDupkf1S?=
 =?us-ascii?Q?4LOloCNnsLNmNixZAZyLHce41ie74/fybQ/mbFW2OC5ioMBZXABv54LX8niO?=
 =?us-ascii?Q?fA2/xnvqNvN0sDVaniLqyztgX13w/0lbjAog1X7Q3pyVo3zstqxmUGtUoTrI?=
 =?us-ascii?Q?Q9PN4oHNUnF/QTCZJuOGLNJsZsPnho6fYPFSTBS0gofgrQncqP4CeVPEtgMl?=
 =?us-ascii?Q?Bqybntu2JpghZWcH8idLf+ycRcgi6S3xlDFh58NsUVoUYTX+I1TCRLbrVPiP?=
 =?us-ascii?Q?NIReRjYxiXkQ2wx350R1Af1234kTSg83ZY8gK8dMRYnI2Z8tFgkHsQ7W21q4?=
 =?us-ascii?Q?rpB8YAJhzV5wTTCCApSZ86JnTYU+SN96rQlNDQklMisCfvlkij4gtL+cWtFV?=
 =?us-ascii?Q?eWhuRF1KqYweUIy/vYS6rs5Kr38CZeFFg0go55m1tx4xRUsTnsb2YoOAiZzn?=
 =?us-ascii?Q?FS1KtUbQGbU26yMpdUIUqiPtrv8PATnI0qM1SrZu5GNDvPjYqBh7yiyr79/d?=
 =?us-ascii?Q?MNScFI+15d4LZdC/6sgvqITqD7ipQoUb5khPf162WDBO7HbbIuvMbXjama9m?=
 =?us-ascii?Q?SbYFJwvmYU05/JmexPWr17wIfxm3aq6tSnLRL15UznuXyeGKZuq30jZJKmvR?=
 =?us-ascii?Q?g8ef3JBR60M1F0kVy34JyCbWN3lkAYJ9pWNLYokS2AzSeh/KOnd5hFb6jeDy?=
 =?us-ascii?Q?cnyw09CAKfUjeZHRsdq0n5XQBwfEN73Cvn1IHqZXB+WVL+ph+M8QM15ZoInM?=
 =?us-ascii?Q?ErdI5rPmgV6lFyozSilbXi2Ae5j0I5f2LmzZs0fP8Rm5Y5cH7v7e84pebU/A?=
 =?us-ascii?Q?e9ExaLXpmGvPiuWeO369/UdLRYfxITlfeXDLrTIi/3ei+mXFreGFsRzuykC0?=
 =?us-ascii?Q?1Z6ztytglYeoBkoerXt+e6ZF2i9eNjexehamNLDBsGIodDx+eVEBPEvuvraB?=
 =?us-ascii?Q?wfab1qJDoN3fpx1ymaGb/BG7Q31JYmmlL5KbVne3/duN29pCHAfe3MGCXVsF?=
 =?us-ascii?Q?o+WburwLBpzdiu+dGgY0zHZcUeLTrH8y5UeucEEarTcqoOiiEx73xpAqXKCV?=
 =?us-ascii?Q?dlYEiyxyiuA7APVCXFgEqAz8FKjIw7XUTc5O9mIKhe+Lxi5i8xv/VJIwRxqi?=
 =?us-ascii?Q?goqPHr7B74WQ+e4M++0EBh9AmJtWBXfJurcasO4adCQyMapogPDwOvxWNPry?=
 =?us-ascii?Q?rZbMqN8NRfO1Ax70Q6V4ZXVoxc36Mfa7PpplYSd4cnbu7narn+jmG04a5ifE?=
 =?us-ascii?Q?DwYZCn1QTreP7KfoOaYY0Tf050Xset4Er2ImlCDYrvRkwL5QkGaTPcz5ahPb?=
 =?us-ascii?Q?YCKRL6Q1BolfJdqe1gS8f6AtQUgeYILx6125neZ2Zcwm55I8e/KBjknr/xrW?=
 =?us-ascii?Q?xXDT5K5Z+wxoUl7KjrP+pgUtJ4lWTqZVbUb+DEmsZhUUpeQJmbtETAa2n9QI?=
 =?us-ascii?Q?kuJE7h4SzGGwHQ/kMXh+iii4hY7DaOSZ/zFYMSsAXEWnrLtX7gf9IQjLBRpK?=
 =?us-ascii?Q?rSmxNXwjUduuWtr63yqAfWnf5JG75iM0kM/7PVstzUn+JinkN+I4F8GiJht7?=
 =?us-ascii?Q?kwjdKDuybTdZVvUkVuMhugs=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	a1Ikr3Ge6lqPz+gB1WvphDlbXyIMd1prSkLkUKkPhW+c7SjI6XBsNHYYQklzYJY7b3yDGHbPjrz+TP6AKjxPQi4NX7sUM4eHfzl6YMjr2fPzVbZDF55CH8pG8AZlVJBne9GHnviWC4bgoqn0MBGEO9mYBza0VsZi9zidgFRVOgy7bi6ZTAUHT1Jrviwbm5PFyYbyHx7Qhd97/fewoD6lYvLFBmlqShvluh0d8PgWX5bk6KoYuTd0SQpdCzonkZ2Xz6f1SfB2V1RUgpgZF+Sh4NuV3TLhcqLobS63VgXa1GvyWA28uXD8gUtSwfW2qrvaSb0f6nD79n5zVeKW55IRNsiEQZrc1ux2ec5RQIevHD5kgeE1HEJYRAJ3ruOTGbjqn63LxuVUOj2maQNCe31idZBWyXDXndnP9A1byzlxAAM3WQ7OlCNvIGlhzW55UTVZl827/Rbjq+52uMMZOr74v/MTF8lgKjbghgA9Ku8wvsh7w8O9qLHvbdcO5WpDaenasXdz6cJ7j+PmxVh66rgQiht2K0qd7M6YsxM+hWcO44D4bWazVMpnXhhBW5KAJu5GkeR5RNN2FsMheyRo/4pIMe8i5fd/Aik0rxWwHijofAk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8e8304-49c3-4f30-1ef5-08dc84bda8cf
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:09.6525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmjlCerX0nPBgEhBGwkYAvw9ygo8LIO6jJOYgXTd8nhbkS+qI1ep/kqOJG/yb4KKy+Qc3TTnt03Mutn88uhxmEu7eRsPoxBuLCOn9F8NrgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-GUID: rBw-hTFVFaLW1hhHoccrVQ1p-fgxij7k
X-Proofpoint-ORIG-GUID: rBw-hTFVFaLW1hhHoccrVQ1p-fgxij7k

Set the correct mas->store_type in mas_store() so that the subsequent
changes to mas_wr_store_entry() can use the store type to complete the
write.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index d74847045bf7..34ff1b3f729c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5589,7 +5589,8 @@ void *mas_store(struct ma_state *mas, void *entry)
 	 * want to examine what happens if a single store operation was to
 	 * overwrite multiple entries within a self-balancing B-Tree.
 	 */
-	mas_wr_store_setup(&wr_mas);
+	mas_wr_prealloc_setup(&wr_mas);
+	mas_wr_store_type(&wr_mas);
 	mas_wr_store_entry(&wr_mas);
 	return wr_mas.content;
 }
-- 
2.45.1


