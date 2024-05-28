Return-Path: <linux-kernel+bounces-191553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9268D10F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F0D282490
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283AA1CF83;
	Tue, 28 May 2024 00:36:16 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED08BE0
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856575; cv=fail; b=B2HnRjftwAx9tbLaJ945FPK9Sodt75FfOvoLRhFNI19Y0Z1nTBvk7ACrDB6r76XQceU8qRQ9Btae3GU+B97gaSRGzVix9O6F/3lQ2kfef832A/hvSZMW1YWKJ+ctsBlF8Zl4l9mWy8LmVtQU+FuEIBmzcaqXsVv7XHyYGkl8aiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856575; c=relaxed/simple;
	bh=/+0z1IsP2Mv++qTpEsoFiG6JTeCdhYUAYk7BD/ZJOts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sri7gqYNF11z5zVyKJfJCTRNVXo369osJnPFZ3VGPsvEueigerZudZeqpEjOqmkzuT/ehiZPhm7VEfqfngzFBBCuXkHsdfMyr4kIrnNzOcTR9GXpUGCIbBvi5vODn0skHkgJRs3yPFVTBDrTDGjDl3HvIsZ9l9y+PS76dS++Qkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44REtQoP013245;
	Tue, 28 May 2024 00:35:56 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DkLaaWNi1sPdgUoO/a7tbMOGsOKOg+5uFKHEtfG9u+CE=3D;_b?=
 =?UTF-8?Q?=3Dfc8hbT/+8jhuKtBq6M4k495NkHhXkyaS6UDhOCy34Rp5iyytyLHPja5I2eF3?=
 =?UTF-8?Q?Kwri3gJs_lT5qNp1yCfO36Lu6lrR5WhKpv0nKlk4m2ib+IblcCWomLQb8X/gYU/?=
 =?UTF-8?Q?DMMGbEdOFMGCyC_2jVCSddlnHMLPuAei+R2R+otFLLJCYDPkEvK3JPjoswHCQ9D?=
 =?UTF-8?Q?bgfCSYhQXwsdk9mpt1w1_2e2M2EDR2PwESjl0hIxh1k4deWlP0uctvnqrxZ9Jtk?=
 =?UTF-8?Q?AwboHpopEtN3G1y6tg3RGuCIB8_isizFz/UUEgSVTm583BW5uC1m4yiE8Vv87kV?=
 =?UTF-8?Q?Cnn1s2Wf5+AyASZbt+Q77Y5CllhIQWMo_pg=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8p7k5sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RLM9MJ025822;
	Tue, 28 May 2024 00:35:55 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yc50p7x8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvOswa/7dJxvkvcD03aw2M2TDOw7i8ApTyAvw+QZbmp0nxkDEeCJWnzBOzZb+O+eryCwg1nE993UPajdUZeqhrrXYZgBvc5+9pWasyjf3bTp2p99ySNu9OM0Bv9xK13kIytAvof2atUKOdzmMHoV8fELv5k6Jhih4TxkC6FAjK/4TwNOIl0wRW5s57oUD5XiWJSSSAGAq8W3IGCLeiwKWAz8BflUMGxXBoHQpEAcv1Z6kbckc9TL5qRDiTj8ozGJ7/WPUpTT3oBwmFzUoYDNz/24n/uXX5fjxcCPxoOWttf6oG+jZ9xTyD8/zGXMjxIflGg4I87L9JE94K/V86R+Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLaaWNi1sPdgUoO/a7tbMOGsOKOg+5uFKHEtfG9u+CE=;
 b=RX6KjcqPurshAdcAvKluMCaRd18J8+dASw+EZBiyWYAa/F/X0dVIXczRGe6dWnYyiysw9XthyeHmcbTs+xQzUULoddMSzdgzm4JPQ8M6ODefCusDWRGDHQsRp2m1OGzVqCDEV7J49DS9lYZa3aqLtZe82KWPRtNQ3Yj2E4Q/3xKd3N+6+65rUN+xBamSsDlSdMV1po62BDYZLPbYgjsFsEdJ2EvO4ptszlsaulglzASD5TtcMR/wEgtX07bYZkpn5cLlmO/UsX9uOA9S9pgj9OKWQYXLUVjrbJQvV0YbXLOqVo3r2bwVXghNpnDMsiMd4kNBGfgRjFz8iKzhz04Kbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLaaWNi1sPdgUoO/a7tbMOGsOKOg+5uFKHEtfG9u+CE=;
 b=vWKQ4RR/TkpCoSbyMXAB5mm0961XNPeiLO0ZXeESAX29hlzRktXCaOn10QwvB518CbyGwQ/YGYo4p7ZC9VbenhuYSHEIdVtDri8Xr9W5fjlebZ0WgDOf0SVGNCZoo489U5pA1euzr5MWYEoVmqwL+1qAVuTGLKQisgSEfpfaReY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6510.namprd10.prod.outlook.com (2603:10b6:303:224::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:35:52 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:35:52 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 08/35] entry: handle lazy rescheduling at user-exit
Date: Mon, 27 May 2024 17:34:54 -0700
Message-Id: <20240528003521.979836-9-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0346.namprd04.prod.outlook.com
 (2603:10b6:303:8a::21) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6510:EE_
X-MS-Office365-Filtering-Correlation-Id: 2882bb66-1f03-456d-e94c-08dc7eae211b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tPdycKowL7vz2lRVAWL77mdCNDXuoLcLyE6vzPsr2/pjXwLZzz4X+CbDEFSh?=
 =?us-ascii?Q?gL7dmWnOaMeGOKecd0yDYXjoMkwLACfIsIpXHXFO5ioJUD5QpCV20qPZOj2L?=
 =?us-ascii?Q?MtvHSPT8RSNu9fkkn4RTa4JAytB7ua/44RYNVwkP+vijV4wg4UVzi97o2Zs3?=
 =?us-ascii?Q?gtumlgGdUGnZa6DTh8SLXjh9NuPBtxQXAqfhEyr/WKAlVjfoO5QRx+ki5m77?=
 =?us-ascii?Q?bhIlI4E4kJS3Jyl2hOCzHzlQ5EYTml97MsdjfAQMH2821JobXIiJ7jlb2Bhn?=
 =?us-ascii?Q?g9Z1321fclmE8sVUhmBWuOQZHZ6/ap1dNecPjdwmenhul+Qfi54cB9j+nnYq?=
 =?us-ascii?Q?9fA4ydkoaO+SrpLr3Aj+IRf1uY6sLxez61KGydJYYHh9pNn19PLS8PnXA3Tz?=
 =?us-ascii?Q?UsiEhK6OgcgzZmp1hPEmuIPrzPElxI1+/74YG7E7Bl6b4lQpdRznq7ec/1jn?=
 =?us-ascii?Q?h3VC5nfqgNvcYFmVcVv398AzWwsEGiV/IBb7suKwGEOjNCkO80TCUfNPWZcW?=
 =?us-ascii?Q?52Zi+oCXBCUWaVeAo80Cx6Sb7RoFaTZjIIMXT6hieTwjIzXXjqaX7rf34yoN?=
 =?us-ascii?Q?mh0SovYbksYZqH1PG+qCkjd5bw70OmStpblpfQEnpxgRpsd4s0IW4rfdwdfn?=
 =?us-ascii?Q?b0q2ZiZI+/97JCY6BhTDr+WhKbnb9KQKnij2FnQk1naaFtAVcjHx3E0PqSVX?=
 =?us-ascii?Q?KEbWx89LSZcI4Xf76mPBk14Pk8iqFOUPjyUK13an96P+j1eVHi5UbwzyRcu/?=
 =?us-ascii?Q?RRf5BCZSen+MYYfe3E1rBcUCYjDydlJO6/iV559PKzMynlRsoW1OqteHTl1F?=
 =?us-ascii?Q?sSccqAoFZvrE8sMSPSczV8PyaOd7CW5iEo9PiEapN1jqguZz7j0ZHnq6pLHo?=
 =?us-ascii?Q?e4r8jlbc7w/QxhyVdQoIV7ymIw8Q52QtCq7x7UCho5QAY3BabFnVBQNStPnE?=
 =?us-ascii?Q?wqjakK21Kap4kB6KdKfbaVo+MizJSqByYEKZq3hi7WV5GNb6aQ+rdYk1SHrL?=
 =?us-ascii?Q?oJwlyhQhuGBKKX2TtOx/fVczXdeEgBHKbYOY9M0yvQ6DS3Nh8QG95GzmpfZB?=
 =?us-ascii?Q?ZGxk7XJJ5Wn+BMZOom9BPhf5QAJyf4LiECGquSHFpjFq0I70nz9L28tffYgA?=
 =?us-ascii?Q?NMVvCXpP2HmenRhECATZ48jn8nx+w655VA7t5V3rlATOdYaD68c/Ce6miOjC?=
 =?us-ascii?Q?bOV0m8UuYfMZfAexafQAlccW0AxhyBWpSZ0DQy+Srznt7sMriSUdbNVBKqc?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Qqeu9Zwah5sFO2yJHHQijEhol+C+ruuVZ/R3XqkicTPhqv5nGN7YrpIm+qZs?=
 =?us-ascii?Q?z1yoCPrXyPT+A4WzyDVj2KtGfIWP9k0ZzXohVSInYj9Y70TvYegmI6P8ykqt?=
 =?us-ascii?Q?Iv5yTf0v0df3HZu/7hHGhOFp7GVUisDXAYkqLxW+QPkx01/422FeTq5LHPsx?=
 =?us-ascii?Q?iQG3dvPRjY/7EP68qVlWN/o7HWKLcpDqaFkDeAK2ohwkEi+8lZYC+dGfAc0v?=
 =?us-ascii?Q?LK+sm7dR8wEQMIQkuGozirdRWWWeX9vcpBzD0DljzN8iJ/0pXCEQvmvOfyJY?=
 =?us-ascii?Q?LWK9BMzdneN0tWxiN59Y71iTLZfV6koD4vT+uiV0Cbzg4Q2xkeZWDp0vJ4lw?=
 =?us-ascii?Q?elhFcMrahiY0IhoRNZooLdpBf+lb71E0nUyG8/0WTdhfIHS82aX/ecoZiZ28?=
 =?us-ascii?Q?7LHa+TBOD9zq4YZD19LKvHuKpTqmJuMuNhURhK1DapnkoP7dk/UBMQ4L/3mn?=
 =?us-ascii?Q?+1KDjDOym6araGXvdL9n0QGky+HIv3bfC4BEC3IsSBSxlTGbDc2b3e59CKRa?=
 =?us-ascii?Q?8CMHRp6INWj4UtUOZGnTAI2XjNh8sOGX92XGiP33L2ln0uQuAnYPvLrkB9Ih?=
 =?us-ascii?Q?8ixknWbp0ijTH8yogIJDWZh2NOW0dDssoVbSEGjZvLnBKbaK4gHcU+7TCnRX?=
 =?us-ascii?Q?V8vBxol9Hk1Np+GknNG/UaeP9Ory1V7fUouyv1ljvbVw9gidssi+KuUgI2Kb?=
 =?us-ascii?Q?XJ1/+9AVPalSGmcHp9jspfDhVw6hkCyIEMrUrEwIw0HrdNy+qINFoz1AtyuJ?=
 =?us-ascii?Q?JC6fBj+gz9q9eatUcXR8/VILr0+fIXlR/W5UDFY23Oby7zg8qkkDM8D7syjD?=
 =?us-ascii?Q?Dg66tOq7iosgclAZ6bCzD1Zn/2ojbTm90B4SQRMLy1pHDBOlfj+6CCoP8gEn?=
 =?us-ascii?Q?86qsCJW5Iy1Vwbe+n1CnthsrNiUTLtd+KBVj6IreC+VBAlm5RtFCYbQ297kV?=
 =?us-ascii?Q?WaZgCyd+paxW9LdGmaFbEltoEJdxQ8opelIxktiK5e6gQ7iNCezlVKfz6rPk?=
 =?us-ascii?Q?4a4KDvzZs5T9rUPG9bLrtBkuhq1sDhFAIoz+QRrR+rqHMMVDPd83hXE3YAk2?=
 =?us-ascii?Q?CSJV3N0ADZxhcdNwJZD1Sq5R4SnVAXwicBOAEg3S921qR/UJTpevaK6QH8a2?=
 =?us-ascii?Q?5iUepjBsoduYlg1sKlIcSPHGghc0uRSljuhUyslyfSaXwUQKciZi2iAQ2OGg?=
 =?us-ascii?Q?1T/IPLOdurgzIOYZcle0qHKzjEvHFcdeNSNveXP0/dWSOD2xG0yy/3IoCbh3?=
 =?us-ascii?Q?WGhJhrtIod1R5OcGpWbXKbAV1UY8BEMrWnxs1sZog13K14GYyNpcLUBpTIW+?=
 =?us-ascii?Q?sj7fkEd5PJEb36GiBjq1uLfLosJesySZMSX/V3H0Lwen1TxXmvu9Lmrdp9+S?=
 =?us-ascii?Q?Ksgu2l4pe1Qmcp7gYaxfdsXKHyHXCHWitNAQjhFP9Wg+qYkp1h+tzEqM7wOJ?=
 =?us-ascii?Q?9HtsptiYQOtgRNUl3ZZcNswq21zCnoE4X1c8GR4o+X4RImtgWTRodR+ZEF9A?=
 =?us-ascii?Q?BMHN/iiYVBtJCwluFNzIV2E2q/f/cov+YO85SL7fPXk0fKXeZ149V8Qkuej5?=
 =?us-ascii?Q?7IbKWzLYrrI5wmeKK8Jl5mG008gPZNPbM0I5UMu2uuW33qcngrWQT52vu9gd?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wcANLd2djhZmuPgZytLKN7mI4bMsmrGXV02O4V+xZ3CAKewTX1fqw2e+0S8ZQ55yYE35mxHGhChLiVbe2AW72mqzQk+KkdaQoBlAiqal2DHr03tmwoTgfumDvRCXui5XNYjTUDbLe6zy19C4itsucOH73c8PlkSaf+YiYD4+o9SoxA18htKtQTdKX9yj4SBm8BM/HDa/6DLWVMwtspi9kXEd9q6OF/4I3ZYzrM4BtJAeB6dG2XF6SLMuMd9dO5WfP7KTSnuChJRmqWlW2a/bdgTp/BTyFZbYVJlHKIs7fP77TcBSVVFQ2ZEEFh7nLq+J6rMGc1yif/OMUiIMW90+mrX9ZIoEAxdI7lzXbFM2MzPNDNXOTeBVuibqxoNkrsXFF8hXBCIXqHOOzU+HuGkD2aJODHSq9b/6PUFRFhPYilZ3vJTgxjvhuA8Ym/QBPNzqflaQYS1YPvwvPd2PBWCbcVLBKxXa0bn+NAG6htZJHwkSMmgsVA3My3cyk9rjn4PiTZpEOezS1RuPXnrIqO2qxiYmgFzce+YB5LA2LR/zLLjkN/s6C09lqioWeD0gdnMgOByBj5pPYsCvTF/1H1g6SvaaH/LIIoUJEhlURP2MWRg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2882bb66-1f03-456d-e94c-08dc7eae211b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:35:52.5419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x8vCoL+2h5XF5+eHswu+KFTB31ZgQyaU7xQDM943slH8OvRDV28ChlR1+PuBs9U/SrkPqa5OFDMqjc2ab7xHIQ7OzmI8Rw9ImXSg3/1suwc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=812 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405280003
X-Proofpoint-ORIG-GUID: 4rDj__0LxYdJV7D2HWdPcQU-M3BpC4v6
X-Proofpoint-GUID: 4rDj__0LxYdJV7D2HWdPcQU-M3BpC4v6

The scheduling policy for TIF_NEED_RESCHED_LAZY is to allow the
running task to voluntarily schedule out, running it to completion.

For archs with GENERIC_ENTRY, do this by adding a check in
exit_to_user_mode_loop().

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/entry-common.h | 2 +-
 kernel/entry/common.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index b0fb775a600d..f5bb19369973 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -65,7 +65,7 @@
 #define EXIT_TO_USER_MODE_WORK						\
 	(_TIF_SIGPENDING | _TIF_NOTIFY_RESUME | _TIF_UPROBE |		\
 	 _TIF_NEED_RESCHED | _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL |	\
-	 ARCH_EXIT_TO_USER_MODE_WORK)
+	 _TIF_NEED_RESCHED_LAZY | ARCH_EXIT_TO_USER_MODE_WORK)
 
 /**
  * arch_enter_from_user_mode - Architecture specific sanity check for user mode regs
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 90843cc38588..bcb23c866425 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -98,7 +98,7 @@ __always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
 
 		local_irq_enable_exit_to_user(ti_work);
 
-		if (ti_work & _TIF_NEED_RESCHED)
+		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY))
 			schedule();
 
 		if (ti_work & _TIF_UPROBE)
-- 
2.31.1


