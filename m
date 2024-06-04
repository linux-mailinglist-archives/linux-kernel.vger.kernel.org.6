Return-Path: <linux-kernel+bounces-201185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FDB8FBABA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13D41F22B90
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69585F860;
	Tue,  4 Jun 2024 17:42:30 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703014A622
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 17:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522949; cv=fail; b=Wfns5MtAJtyTyuZBBSKDTHD5nhYO+rLnVxFaSZqQ7UfpP9OT5/zpC70OQulfYcuhMMteVyvI6LTXE9mw29wCK4ju36Vqb1AS6jwVX3nNozFTH07UOwzcK6zbsPUTJv/U+TDv2enhZjK2iuMa6RJtshu3Y6yPwJ/NMwz2nb5Ux7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522949; c=relaxed/simple;
	bh=EF3oQXtqIaKVD6YYzoRSRrisiKxGk5sCfo3r7kmpD28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TMVXFg+c1dUNJ3YrAyj2TZSNd94qds+gFoyhztjjxRlDPgD3z94Wx1XpfeKkp/M60B72d3kL0ZUmUUhoQqYgGfCeHjLhlpgV+OBhxAZFXitXTawFBulAe/vFHaiNJNp5Yt5/7nm0/Wn9sYKyFsOg1x6drTVLsCM4dRSBEf3tJMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454BnNwA028131;
	Tue, 4 Jun 2024 17:42:09 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DRMx6uAATy7QTVcRAH9zV6tiagLCEAV9FtRSVTr0+QWc=3D;_b?=
 =?UTF-8?Q?=3DS6Tp4q9ARLvKipWqH5fthgPfGLhfKkOAKqmqDll6lMle6A2SKwNXztHOAouJ?=
 =?UTF-8?Q?wEmNYNcj_dtFVO4FCq8s3h/1gDkcmKFwS5sOwie9Gmca+kK0z0YYLx46TCR5cFk?=
 =?UTF-8?Q?ezSfjXf/S/yzMi_tME30V57An+LtCWun6miwan720YRCab96A/5rjJzJ8ch0x41?=
 =?UTF-8?Q?JJxgB3M3fm88Q9D2e7xC_oES+6jE2QbbpHxQbU3ZLwGpBVmfWoH/NBWu8It6AcD?=
 =?UTF-8?Q?ZgVuL6MTsGI+gQYqYbSFyiTLUO_7qilIxsMVV6Dx0O+7jXHIl9lPyXmZs252Eni?=
 =?UTF-8?Q?AqtstUSlmwO7/8UtcS9YB0qF7rrAebnp_Rw=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv58dj9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 454HNoQj025242;
	Tue, 4 Jun 2024 17:42:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrt8xx21-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Jun 2024 17:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3WycuekYfUB04VJuoVa1sQQ5HLXtOrpkvEj3cSdBilmnRy/sB0AtHXTIQWwKNtc/Vj6XbuAR1lVH1rI4nRXYCRhvUNmvQ+o1QYlPVKW2gI7aUFcPlXnxOBxBbb8Pj8x2sE/l2bn7w3mLla77xSlC0Yai1TlCxqRr3WquXjS4Xhky7HNTFAsfVAluBMVWDlMRF34lfsC8/y1MhGvwQxR20W4TRyewZsRmp13wL3IUSkzYcXrTqVH5yvy4HJ1atkBo+6XtvEFGSzduGkZc+qWAvsWdwHDWtsr1GyhWSYdWLgbPO5Y2N1ZVm6YuAIutzkGnC+K6lop1vPj9TXSOMgGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMx6uAATy7QTVcRAH9zV6tiagLCEAV9FtRSVTr0+QWc=;
 b=Vi5NxHzXt3sycoGzRBXd0OEf6Ymnn0fuhXWXGJ/+JDA8yd/kT6OsSVLZUgCdmtu/Q1l7MfqIFe+UwVJMyspYJY3GuKOb8sa9HTzFt2LaA5Oooqt9PEIwU3QRZCMLHxf9dSp6EYTX881Y8R4TYJysnO1/q2YYerijx6j9sGp7SO4+h06aI47mtTUPU2WO0bZk7CWWABAlMi57Tmi3OC/KA9s1/C9tUV7mIOGsjlPIDTP7GQkMmJ8Ox4uvK9RJo19tTsfBc99eOSZxArrjv/pmJGtVjBOKsXi+hGvsFQxelkgZH7n2bhiyJ8+F9aUg2hiihsZ3VhWf7tgCReYU0ikKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMx6uAATy7QTVcRAH9zV6tiagLCEAV9FtRSVTr0+QWc=;
 b=fxqSD0HJzvaQmYkGEEXUhaD1oGOypL4gaCytaWuyFN1oelsBVKjZe7bzxqDUAj+gIXpi/Qe++GTmM+ShmDvLI1RqSWbJ0EU+osogZGcGC8WJR5+gapcHCsezCvT0BZgj06vDb22UgQN/8lCOiJNsQjv2E6oWTHY7Ty7jANJPKwA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA1PR10MB7593.namprd10.prod.outlook.com (2603:10b6:806:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Tue, 4 Jun
 2024 17:42:06 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 17:42:05 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        zhangpeng.00@bytedance.com, willy@infradead.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 06/18] maple_tree: remove mas_destroy() from mas_nomem()
Date: Tue,  4 Jun 2024 10:41:33 -0700
Message-ID: <20240604174145.563900-7-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
References: <20240604174145.563900-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:a03:505::20) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA1PR10MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b9b646-c952-4df8-9144-08dc84bda64c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YiHAjmRAmUkkNvHpu9QAWBTt4mkzhEuyccGYqtEEye0lkvtJSYApXZ1OMR9J?=
 =?us-ascii?Q?IqHMEdjAFgXDFmCn6V3GiitNrbWoCJvpz1h6kOiFH6aSQ4ZCo7cOCDCYeYVL?=
 =?us-ascii?Q?3qJEzlNNNKz9fHJ4LXyax9bHEBVVHmq0gm+54SJJu48vEECz153YZSiFqY+W?=
 =?us-ascii?Q?Cc1B5sO/j+AvkYf7leHOHPdmYBq4nRgLGXgU6Rpx0YN6Jpe9xMxkPvxu+xnd?=
 =?us-ascii?Q?5GAyMrk4NPKW9sd590CAefz9awesUv6qM4egUFe55SsmOkir8mZ5op9Kom6I?=
 =?us-ascii?Q?fuPsBuusM4GXcnszaluDXU10gzb9QZdzyifGCBnykpsig7lqPNbck7eLQgvb?=
 =?us-ascii?Q?S0NrD+goj7Hel7XKbnEvz31GKmD9myDY6auwSNF+nSHFMTpHMSXEmr2sjCgQ?=
 =?us-ascii?Q?lXDzRavYTRPbqc4IKBlKIHpw5DWvZFhPbUM5+C4lAddjzANcdpzv4bEvPcRp?=
 =?us-ascii?Q?xXckJd3XlavmU6FG9VvCnXO9cCv3Uy2KvHaOpHSMTs4C9yN26+BT4SyVWCGI?=
 =?us-ascii?Q?EwA+GI11rpJ5SCcmD/M1ZJPvgEB3l5AZ0AKc9+RLnhAoljFXwVP44/4s2ieS?=
 =?us-ascii?Q?yPsfqxGbmtRo/GAL1T/k6vG9GLT/hM5G+jhmeCP7d4LMIPU6DLDyqzZ2ei1x?=
 =?us-ascii?Q?PSA0ldCVJH+kCida86GVyOriYVoE2IiCSKYq2NCjl/OGiA5EMG8NgDVlFdnH?=
 =?us-ascii?Q?+70Zh1nWgmKx18asT0N156DoqPmCKetylTCba4GtLEgmqmTco35FTL9Kdxyx?=
 =?us-ascii?Q?h406VKh0I49wkCfm/r9GpiLu0oKDLvgSkUTEinYAMcGfORdKhvateZbOLWga?=
 =?us-ascii?Q?xAc0MRtcUMYWpXDhqrgFyDNmOiXkSyQZma13dRFh0IDGlJMKhObZMNOUDfFJ?=
 =?us-ascii?Q?uQ4mBu83gGuE5Opr+CsfxPRYsz5bQw5nPp/hh9y/nJ224XmrSBreGVOwVayZ?=
 =?us-ascii?Q?JQZGl3j3Djvvx0KrKrFkbGGiScMN4mLndQPbv/VL1pq5GSWq7/EZBsEbWYOh?=
 =?us-ascii?Q?X/3wlFkfz6pU9oBk2YO9SCcaXl/OYvulQJCPm5hDPRUjAzsetU5go79TCd+x?=
 =?us-ascii?Q?OH5XqpZLL39WMN6RunHsENou4SThypCi9cG38SgkdVtW4+o/aYyC0kKUf9iJ?=
 =?us-ascii?Q?eh9LN/hvHuDgqF5FBn/efR5XpgzNoN9iDqO7u0ugC+Zgc0tERlMd4vimJklu?=
 =?us-ascii?Q?/v71EqyEout6Vdd9AL9oq3tq0Me8DQhVlSmYjBP+JcssJliHZbYlFjNZtZRV?=
 =?us-ascii?Q?cYRQq0723mMp5RvLoggLvjtXU/W6V4T4CxDpglsp6Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Nd1wa1ulr+wrHbN9dgFwv5mYonHWbPzWO9b8Jsw4UEdNR8jmJ6s1TRzX99o0?=
 =?us-ascii?Q?jtQCQu3Uzm4grPg3bDESCr7NflIXAZwrLidQzE8TWZnwm6WIJ4Ts6hh2Q1FZ?=
 =?us-ascii?Q?tOTX8OcP60U1aMv8AYgjcINOR4MVUP00LICbGPDOvO+cKB/JLiQeqdUvnVdc?=
 =?us-ascii?Q?SbYu7B0ec1rI6XSWolPSjFp3doZ2AXUgLNf2X5WIGYkq1/HK1LnUIQlNjfC5?=
 =?us-ascii?Q?eMHiXD1V3p4bRBceC88r4S+Gjd16KyGuQyT4YbN2c7bXiIHMbA1Nfwk8kAM2?=
 =?us-ascii?Q?z7f5hcocat3yS1F+7gFv5W7+gwfJ0sb7byVva5q1JtBRqEds+NS26YPUcoD4?=
 =?us-ascii?Q?vs80Xm9XuBHpKKTU7LFMmuHzcNsdpxklONQGzOiEknc909SNhKP0UvoaVeOG?=
 =?us-ascii?Q?57XgWAA/mvwBhj5+JGxnnTqV8VyKRISMmaRwm9KOagQjJ4ZedgnC9Ka2N+fJ?=
 =?us-ascii?Q?FvGJ2Esm53yyIiTF1mb4y1CxSgvQxEAjLlPEMCAcaw6hR5V4qpQl6JJtyoaK?=
 =?us-ascii?Q?pxOx7AH9qFdwEIMkNmrj/VKqlErcH9QU5muhwxoQKbMnPRbIRmRmP0K0aPpk?=
 =?us-ascii?Q?LbeAZJ3UInjeU/1+4fXwezKy1Wqj/AzPmf6iaopUo9cnqUCc+EZZEJg+M6VC?=
 =?us-ascii?Q?t+BNcvUW7+3VqoVe0FYxVtv6HqqtDz9MYUpYkfhlvKMg8y6Kj0lZlt+UjNPs?=
 =?us-ascii?Q?xv3SfSTXMeaaFnQDAlQbsn81/5wPY+rKyDYTLPOnWWenAXlW81xyy2WZNbJH?=
 =?us-ascii?Q?mloYPlUb2d3C0Mfb59AcU3OYbQn71a8zcPL5uF0cll93rCsMEN4gTy04370S?=
 =?us-ascii?Q?MfVKmkuVeSTeNEDs3+OPcw2/8WisQPukZMvqkEsdachWTeS2dQJYmhhoAVv1?=
 =?us-ascii?Q?ChGB0Uz+6+z3f0MSpi0DgTB8TwKG8DwnffXB3gN6ZW/vHibtj6XowSollrZ4?=
 =?us-ascii?Q?PE6MdL8Y5wF3X/F9miogv2BH0t6Vpgb8O1qSbVE9bDADwdXbNKZqbvWaGd4D?=
 =?us-ascii?Q?UKLGxK6BANO8bObNr/0wgv6SnS2yvQ90YUQEsU27HLi8bVqiX0TXDKI0t0mn?=
 =?us-ascii?Q?oTFApG+cUt98VRXHmMtlWGd83wJ9ooHrz+u43N9r2HulsCB1zu4jlo+OYp7G?=
 =?us-ascii?Q?R+hS8s3ykUsk8UDKCnyj2pg/sEgiWlYOCLb8pZD30gP7RbaKC4GmM9qEjSzN?=
 =?us-ascii?Q?3Ps1LZm8QOAUxtGEGpqvIkqUo3e+wfGNtTKVV3gjl8RM2AOkiTZeYYaN1jMi?=
 =?us-ascii?Q?6qAq+9vmCF9KkqXmxsTKBAXXqSYwrHnWPJU3XdhrTy6X0OQ0k8NT39SBMp39?=
 =?us-ascii?Q?PQHjLS5X2XqCTrm5wRr1jWDrSOThqpaKIyGQH8Un6Jj8D7IbEJpRIXOV4Urm?=
 =?us-ascii?Q?hJRRQSGhlxR0raHVR0nPbT2EtMMRS2O/ErVDjb9SxjaPjarzLI2NRqU/qBRQ?=
 =?us-ascii?Q?6HLvGs9NE3fTNNPILVXR+/rJVugDO8Oh54u0y5P9lFKlmgA48cUdIs6FPi0+?=
 =?us-ascii?Q?cMGJu8hOFSv3Z3oN2l8ZLQgweNc9MpD0GHmNB2DC9/tiN3fJhNHiH1j6HtDt?=
 =?us-ascii?Q?CKHaYbAGvkdP6ElQo6fM98mOho2zzcDhcbb/7KPsyug3M28gOv+A9i8GpcI8?=
 =?us-ascii?Q?xfm2Vu7zSbQD4oKpzYmd4gM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OcsPUAW1XtaFRMsrPAHgAJSpevE8beW+JGRhIYqL/YMo1xAsZdlkv6h0nQfc1BAc17GUbMlsHw0tYOoHPSnMrREmNYW/ouqdgaMeuZ3ndJrnVYifGP78mzvOq0gYoX3XUVg4S+e0/y55zuvrLhT6ILR/0Ub02ebaqaKlbDHKdkf2fiSFHmWnKAvt3+rlnOc2KK51kc0UyxcmG2ZBXoy55ycOR5liLHgiFz8oU5LySFKkwvgj/FsfBRoqSRvSQsbybM/9OfwhN0RBJwGOzaUkO4syyKt0wA1R0HPOUG1FV1BeHl9l+jFciN7o3Kc8UFgFPbCg7SkBdIhZdVw4GHjNZFWWafO6ZO2ym1CtXVDp6l8HLGG8X33G++wQZlDvTC71a+sl9Idiv5t1zSdOsBkjRVE1Oyev4D51Q9rBmnj0Lcv484ev38Xpg1mBu3I1ikOI1aiFvHIOQ+OtvRgSPdBYjf/z17s6jwdB7EW4W/MggicjHcVJTD/UU78JCHsw+42rFpmOXGFG68UsNMwC8OcLZeuK+AuztfEJVNctunNDi9NBpmqUbnUYWQqFYVQjwNNUuVFVfrKaYr+E6lEfpd+SCEuzHQ6lkimLjeey1fqEBvI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b9b646-c952-4df8-9144-08dc84bda64c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 17:42:05.5732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/H7kmfCRvKTO8j+9dQwQYTsyE5/O4jKxJjkg1Iq7l8LcLSOyzIy4qcU9GJ4zFjLrrzAxDYEp3emaX7OQWGcrL7VFNEnxVAgnbzn47kk68c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7593
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040142
X-Proofpoint-ORIG-GUID: ZqddAFvbfuPVpoEFuezy6a7vt05sgPvX
X-Proofpoint-GUID: ZqddAFvbfuPVpoEFuezy6a7vt05sgPvX

Separate call to mas_destroy() from mas_nomem() so we can check for no
memory errors without destroying the current maple state in
mas_store_gfp(). We then add calls to mas_destroy() to callers of
mas_nomem().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c                 | 39 ++++++++++++++++++++------------
 tools/testing/radix-tree/maple.c | 11 +++++----
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3780d4bb0415..f1496817e52a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4526,6 +4526,7 @@ int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
 	if (*next == 0)
 		mas->tree->ma_flags |= MT_FLAGS_ALLOC_WRAPPED;
 
+	mas_destroy(mas);
 	return ret;
 }
 EXPORT_SYMBOL(mas_alloc_cyclic);
@@ -5606,18 +5607,22 @@ EXPORT_SYMBOL_GPL(mas_store);
 int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
+	int ret;
 
-	mas_wr_store_setup(&wr_mas);
-	trace_ma_write(__func__, mas, 0, entry);
 retry:
-	mas_wr_store_entry(&wr_mas);
+	mas_wr_preallocate(&wr_mas, entry, gfp);
+	WARN_ON_ONCE(mas->store_type == wr_invalid);
+
 	if (unlikely(mas_nomem(mas, gfp)))
 		goto retry;
+	if (mas_is_err(mas))
+		goto out;
 
-	if (unlikely(mas_is_err(mas)))
-		return xa_err(mas->node);
-
-	return 0;
+	mas_wr_store_entry(&wr_mas);
+out:
+	ret = xa_err(mas->node);
+	mas_destroy(mas);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mas_store_gfp);
 
@@ -6365,6 +6370,7 @@ void *mas_erase(struct ma_state *mas)
 	if (mas_nomem(mas, GFP_KERNEL))
 		goto write_retry;
 
+	mas_destroy(mas);
 	return entry;
 }
 EXPORT_SYMBOL_GPL(mas_erase);
@@ -6379,10 +6385,8 @@ EXPORT_SYMBOL_GPL(mas_erase);
 bool mas_nomem(struct ma_state *mas, gfp_t gfp)
 	__must_hold(mas->tree->ma_lock)
 {
-	if (likely(mas->node != MA_ERROR(-ENOMEM))) {
-		mas_destroy(mas);
+	if (likely(mas->node != MA_ERROR(-ENOMEM)))
 		return false;
-	}
 
 	if (gfpflags_allow_blocking(gfp) && !mt_external_lock(mas->tree)) {
 		mtree_unlock(mas->tree);
@@ -6460,6 +6464,7 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 {
 	MA_STATE(mas, mt, index, last);
 	MA_WR_STATE(wr_mas, &mas, entry);
+	int ret = 0;
 
 	trace_ma_write(__func__, &mas, 0, entry);
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
@@ -6475,10 +6480,12 @@ int mtree_store_range(struct maple_tree *mt, unsigned long index,
 		goto retry;
 
 	mtree_unlock(mt);
+
 	if (mas_is_err(&mas))
-		return xa_err(mas.node);
+		ret = xa_err(mas.node);
 
-	return 0;
+	mas_destroy(&mas);
+	return ret;
 }
 EXPORT_SYMBOL(mtree_store_range);
 
@@ -6514,6 +6521,7 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 		unsigned long last, void *entry, gfp_t gfp)
 {
 	MA_STATE(ms, mt, first, last);
+	int ret = 0;
 
 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
 		return -EINVAL;
@@ -6529,9 +6537,10 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
 
 	mtree_unlock(mt);
 	if (mas_is_err(&ms))
-		return xa_err(ms.node);
+		ret = xa_err(ms.node);
 
-	return 0;
+	mas_destroy(&ms);
+	return ret;
 }
 EXPORT_SYMBOL(mtree_insert_range);
 
@@ -6586,6 +6595,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
 
 unlock:
 	mtree_unlock(mt);
+	mas_destroy(&mas);
 	return ret;
 }
 EXPORT_SYMBOL(mtree_alloc_range);
@@ -6667,6 +6677,7 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
 
 unlock:
 	mtree_unlock(mt);
+	mas_destroy(&mas);
 	return ret;
 }
 EXPORT_SYMBOL(mtree_alloc_rrange);
diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
index c57979de1576..c834e91e6810 100644
--- a/tools/testing/radix-tree/maple.c
+++ b/tools/testing/radix-tree/maple.c
@@ -119,7 +119,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas.alloc->slot[0] == NULL);
 	mas_push_node(&mas, mn);
 	mas_reset(&mas);
-	mas_nomem(&mas, GFP_KERNEL); /* free */
+	mas_destroy(&mas);
 	mtree_unlock(mt);
 
 
@@ -143,7 +143,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	mn->parent = ma_parent_ptr(mn);
 	ma_free_rcu(mn);
 	mas.status = ma_start;
-	mas_nomem(&mas, GFP_KERNEL);
+	mas_destroy(&mas);
 	/* Allocate 3 nodes, will fail. */
 	mas_node_count(&mas, 3);
 	/* Drop the lock and allocate 3 nodes. */
@@ -160,7 +160,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	MT_BUG_ON(mt, mas_allocated(&mas) != 3);
 	/* Free. */
 	mas_reset(&mas);
-	mas_nomem(&mas, GFP_KERNEL);
+	mas_destroy(&mas);
 
 	/* Set allocation request to 1. */
 	mas_set_alloc_req(&mas, 1);
@@ -275,7 +275,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 			MT_BUG_ON(mt, mas_allocated(&mas) != i - j - 1);
 		}
 		mas_reset(&mas);
-		MT_BUG_ON(mt, mas_nomem(&mas, GFP_KERNEL));
+		mas_destroy(&mas);
 
 	}
 
@@ -298,7 +298,7 @@ static noinline void __init check_new_node(struct maple_tree *mt)
 	}
 	MT_BUG_ON(mt, mas_allocated(&mas) != total);
 	mas_reset(&mas);
-	mas_nomem(&mas, GFP_KERNEL); /* Free. */
+	mas_destroy(&mas); /* Free. */
 
 	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
 	for (i = 1; i < 128; i++) {
@@ -35846,6 +35846,7 @@ static noinline void __init check_nomem(struct maple_tree *mt)
 	mas_store(&ms, &ms); /* insert 1 -> &ms */
 	mas_nomem(&ms, GFP_KERNEL); /* Node allocated in here. */
 	mtree_unlock(mt);
+	mas_destroy(&ms);
 	mtree_destroy(mt);
 }
 
-- 
2.45.1


