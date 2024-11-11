Return-Path: <linux-kernel+bounces-403596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F28B69C37B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 05:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D638D1C215AC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28EA14E2E6;
	Mon, 11 Nov 2024 04:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="lKv5MjHT"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA027132103;
	Mon, 11 Nov 2024 04:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731301106; cv=fail; b=KDNl2QQ/6yT6fPdcXNPIo420HuQ3AvOpPj6S7p1aDHaDDtO7U7sMbeG7WrvnQOJNO5c2YcZluRc6BBMO/33EuH/Ne68OJ1lrB6/OMrSys6QkXo0w3w/r2K6njgcXXdUsq15zE164CC0eDsvlA+TOaAgLndSaCQ+SiUOGWRwmNYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731301106; c=relaxed/simple;
	bh=XOUEveWA1o6gtlUP1eLgd0r/vTqh37/gOJClQXtHMQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=orq6FCYHhx3xMO26MQqjMOsHfSzoN1NgLfDQqnWG9fmO0vnuUVgL3aF3INFELLbXCrRCp+egBbhjiJ6yhwGy7Ub6HeAGb9Ev5lSMhwWND5EfDxqPywrHvJz3Ihfwo4rhyAmp1mw++n44DDfnqppr0CbtmrADR2HF6AKNDbcBVrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=lKv5MjHT; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB1bIZZ026641;
	Sun, 10 Nov 2024 23:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=saQt/
	0lJcnC6K3mHClQ3Id7Pgirp+SArTeI8lMRrnYI=; b=lKv5MjHTqcUoSZrraTXUq
	9hBisIDriz/JerLiBYuO1ySEw9sZYgBaP8tJ0RwmjGjnguUDYb/tWDqKDg6vmKQs
	xDb4unGf+EQFbplGNheik2kAG/LQoCCj0tGtZauGtda4b3a0tDSKeaBPSWwlQQjL
	4GP62rWqa+mljrk6GJEv1f5isegS/aWoBBGPP/0jEpJ79PQGYywcTG4uAFPBldT/
	U44244oneqZtCxaOco6WciK577osrSA8AF3dx/yaH1W1LReAPi6gBUCrDaB3yXzG
	ZokdzzQD47/lEWrKyxYvaCdktAMKALO8fo7u2zI2EwcA8s0rbKq95QadRLLgN8IC
	A==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011026.outbound.protection.outlook.com [40.93.12.26])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42u8e08h39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Nov 2024 23:58:09 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZJ/PeEVnKwdKQadcW+oN97wDwObdTBOAOK2yfkBLvcXo118bdSPVc8MYkYzrHjeAgxrqAEvmhmAyae5w6nBBwoMW2SqQ6Aa0lqHVtah6OVLTZmGoywy7tfMj1ItHsvkUF/AFBSBfpUHJXpLR8lms9QRccI7ODlpvMFHatNZn0ztYMg+adFPGUHdVpVzs4cHxhg+P5cyomI6ciZu3Blu/XzXbmOb5YWIIyOhDOlT6mIrGs8AsiVx5oGagWuxE9aR/HEoHFgU78FUKPlRBV6P0PcnFg+d3L2C4J4Dcj8NHln7G9X5trVfjI9yy5inOjVjFvlmMVEjcvKHQSmbtAR1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saQt/0lJcnC6K3mHClQ3Id7Pgirp+SArTeI8lMRrnYI=;
 b=UCrXds8VYqlRGvD8avjbQhapfHasbTlJt9msMtFzNZvgjTEwDVwO1KYVIWG2CkOtkBmjRXcWrWqg5JVVEOjHWOBXrU648SeRtEnAs83XdH2JoIpsRfwdLUb56kQ5Pleib3zgA0UUEMHiBHHVcDzcMB//opT9BZD9U8n4sM8rx8pKl0Dv479wDQm93KHMk7aDKajjPbVqBM5bgxEo7t8K4qlRUG2teKRVROGuD28DFN3No4aaeLGuiwpTshf2PEl85vCV3EexO1mYyvbJB36U2hIlITpuN1dd7QHqqc+lyyXbUE6Pw4AxNmX1vn7h7triUbSFLAGWVCsCv89XxPxNNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BLAPR03MB5604.namprd03.prod.outlook.com (2603:10b6:208:29a::12)
 by MN2PR03MB4960.namprd03.prod.outlook.com (2603:10b6:208:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 04:58:05 +0000
Received: from BLAPR03MB5604.namprd03.prod.outlook.com
 ([fe80::3c24:93fb:94a7:241e]) by BLAPR03MB5604.namprd03.prod.outlook.com
 ([fe80::3c24:93fb:94a7:241e%7]) with mapi id 15.20.8137.018; Mon, 11 Nov 2024
 04:58:05 +0000
From: "Calam, Ramon Cristopher" <RamonCristopher.Calam@analog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
Subject: RE: [PATCH 2/2] dt-bindings: regulator: Add adi,lt8722-regulator.yaml
Thread-Topic: [PATCH 2/2] dt-bindings: regulator: Add
 adi,lt8722-regulator.yaml
Thread-Index: AQHbMcGk+onE/m24OUKzuqZ/zFWO27KtQz6AgAQ6+6A=
Date: Mon, 11 Nov 2024 04:58:05 +0000
Message-ID:
 <BLAPR03MB5604C86F81EBE10380C7EA0093582@BLAPR03MB5604.namprd03.prod.outlook.com>
References: <20241108093544.9492-1-ramoncristopher.calam@analog.com>
 <20241108093544.9492-3-ramoncristopher.calam@analog.com>
 <qr72zky2xfy4uzcm7vqnipgx3nkic4hp377jbtha46cktnxncy@52ms2zg3sf7w>
In-Reply-To: <qr72zky2xfy4uzcm7vqnipgx3nkic4hp377jbtha46cktnxncy@52ms2zg3sf7w>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR03MB5604:EE_|MN2PR03MB4960:EE_
x-ms-office365-filtering-correlation-id: 799df709-a5a3-45a4-2818-08dd020d6de0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8QuoruqyF7U47zl4DvrGN0dYklH+MqvroqONZqzPfJBveNBBrjTeZLAU0CQI?=
 =?us-ascii?Q?zS9H7DCaAvTXY04mY+mjO5IuoUj1fchQPBbdbv5J/VlbKWtSd5WhjE1FlEWF?=
 =?us-ascii?Q?fB4EhUsrNjjE8zrVpeaVgDIhVj8Lf4UvlizAagT+oKXxlp+JU9Cy8OANK7Zc?=
 =?us-ascii?Q?TcFeAeOoKosYJlgBm7XJRZdkhJL2PQ71wmDkXBb/CIfAn1mOe6TGI7e8JRnp?=
 =?us-ascii?Q?k0GSwtNji44zvex4jpPzIgoCU7AA6nhUmnGy4cpE6seZDbgFc7sPrcHLya2g?=
 =?us-ascii?Q?dZn9RAVUlR7q/OX8T2oH1q19Xk6XMrK33PQl8ZsOMFmiHiI6vbaMYRMc1/AN?=
 =?us-ascii?Q?OSksfSXXfjyrj9Yi93f7Wwct/1Z/7KazN8/oXBpe+Kn5CekHsmq+oUFzzSkp?=
 =?us-ascii?Q?3EgQmiUJfFYZrljEg988VvfaTo70qlGCjaWt+Fs1vfRgpDnJb1BjH+YwSF4U?=
 =?us-ascii?Q?QAqELLItU4nRpf9OSNrtkRCvVZmRnJ/HQ2eYUXC38143vml+YVXI3q9vy0Nz?=
 =?us-ascii?Q?vsZRsnGAV/z1HK80PGAru+QubYfx5cZadhYF6L5I+jbozM9lRc2mphwkHAgj?=
 =?us-ascii?Q?SQcYPDpWcmHvBEbiYI+K8ZiLZyf+cGMbJNpEjZQJn5JwokfJzbBMfee4SVPq?=
 =?us-ascii?Q?I9eiSu1Rd5jOP2137Qn3O2mKCoL5L40OSTAXF1HhnmFPv+OvOQuRjEz1VLx9?=
 =?us-ascii?Q?dMWjvUOzoztJYLXF+yIYnovdmrQ92OYdGaTlNeNyd60EoQB4qSBoHvuhfWvF?=
 =?us-ascii?Q?Z2WtZvUSLTkrPhFZb+lmthS2jceqgCTDqqwb70jV+282rcSxQVKXhgVq401h?=
 =?us-ascii?Q?fDHhl0G0H/AyKD9UEbWxUEbmXXnwC50yS3h07yAmVuVG1Ra/NAr6aRvxFy4k?=
 =?us-ascii?Q?9PFtX6Xm4aDSfHv/P9riyALCA0+cpApJ/sVOMN1K7BZ/um1scKkSCN2+l1Ra?=
 =?us-ascii?Q?TRfisQ1BOd8KrHMutGYfgCtPcSENUXmCJeLVn4tljew7QkKLCgLrDHM7ctsY?=
 =?us-ascii?Q?B4SIcnWpy2B/ZM/J4rCXtxz9RrArPp3SXQum9f7DnWLjH6ikKxki00Moz2VL?=
 =?us-ascii?Q?B6pCkNE17Ywa4zoHYuHpJ0PRBi1Wf2TiSbJa3GCw9Updkr83/uwI+jAAvjkj?=
 =?us-ascii?Q?474yU8lttZixLY5QDNL0AIDtJ5nv08RAgDO9w8Xf/NFE12AgSQaaUPX4+CS8?=
 =?us-ascii?Q?tLBAy0XJjhPD56TzGvqD8M2bfLj1VhYwauGTVEkzVmeJWLiMPppkUaBOaVZc?=
 =?us-ascii?Q?/YY+4z0TS9KAYXqohJ3McB4JWfOD1XV6BMC/RrR9Sz3YSU8r/10mqyH22Wfo?=
 =?us-ascii?Q?jhpi4nOa2Cck+B57czj7N+vZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5604.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hHV8eG1KRKIaKCxKfKnUtVgH8QEUHSK9GQejCVYMWkEgO+WDOzX2LoYVfQrp?=
 =?us-ascii?Q?QJxJQNupOsS3cjmHEvAZnpHZRSjBBtWSQzxHoH9As/jFspspEzmZn+rQ+R0r?=
 =?us-ascii?Q?LEtZRzemCsYcH9ILYFZmWzVcXxIFJ9CsSp/+2ZTUOcp3M/vptuMGLniXX4qO?=
 =?us-ascii?Q?5pMTC4s0/jOjRDFE+vRDtt4B412x0Oxi9acGZhxVakiVpSMdh7eo6r7JjAo3?=
 =?us-ascii?Q?RxMnulRF4eJ/nI3xN5xt8oVCsjhpeFcret0wzuFLsQkA/m/SFz7CpWw8j5zw?=
 =?us-ascii?Q?vjwdLOSh3BEn2vu1u86od1a7Mgu03RSKHp2UqtFciytaDKG0h1gA3tMxVF6h?=
 =?us-ascii?Q?RwT9x2aLgPKXGJgLvszkLd/TSG+0LKIMIK3Baw4adGdE8+HkUjQKsEpHUA46?=
 =?us-ascii?Q?RLI50vFi7YU30yBooQyGmyDDE/wHARhW5ShzhERmDsmaue8c/4OKZfJEiV8m?=
 =?us-ascii?Q?Lasau0KfUH5zi9AgGR6a7ctrE95ULk5md6vql6eKtz2QWfM3h/22ggZOncoy?=
 =?us-ascii?Q?d/cESAwQvAG9a1nm7faFP2b8Rtb4gOb09ahzdrgrrl7KiB2cmdRC14zLvm/F?=
 =?us-ascii?Q?0r+e9DFO2NXVk2opAI7HJ+/d1K5GzwfTRsGQrUGvchUuq184/bca5TiVxlsX?=
 =?us-ascii?Q?dWAnNuDDNZ3jPuWKUxeYJ/GQD4x9Wd90uA0IXSUBiv85FsDCE9eGkC87NCMZ?=
 =?us-ascii?Q?uYgbskvXU72vfL8+iBd8sKHp6TRHftczhd9jWruWYbn1RjYFGt6dWeSDjpS4?=
 =?us-ascii?Q?S6JbAQOnhb5tRx+zkDxIAdWbWNue/npRcaGfaslr2I7a/3j4ANOaK9G9aT4v?=
 =?us-ascii?Q?7OkwD4IZuGdFfkONg9yMYxTrp9XgySrIgd02axvL4w3oZy3Slxt7u5DYT2fr?=
 =?us-ascii?Q?e75OwGfJuHa6QQS8CLbz9T3uuU8NXhwOvwkP7NC5OLEf5EiQvdQ3o1wMXCZI?=
 =?us-ascii?Q?BZiK8LRU6zuzU8UxqaWTk4TFrQ1CwVE8sKenNqTCX6MUXLa2vApD4emsteEY?=
 =?us-ascii?Q?JF90AnfBlx5DeHdaZdLQi7ax1Q+c2QUUECkFEK2fXSDrYyhHS9I3v3ZFW3qO?=
 =?us-ascii?Q?/EUsVIJogjKSogsm7Y4MTqRcHEhPJ7Ty1R2pZ0eIdn0fi0MStpCsadu5p05P?=
 =?us-ascii?Q?DX18fqrQYYysTeAYsCVipYE2r/0KxL4vWUgwerUtVyxF+JBSK4nTtYRNQQLi?=
 =?us-ascii?Q?EWW/H+BesKQU5d6Zp7Flupr+aTy/Nyv1Mq4eg4Clx5o1wzud2wdtaye0K42i?=
 =?us-ascii?Q?SqsbqLQcoOokzOga6FiHmrQ44ulZj7mBhVEbenOPkQrsvwElxWRzjCsZ61/B?=
 =?us-ascii?Q?zrXP9du3Cs087Puv0TE7UUvG3/N14g+dRa450ca6j5ycCQmtqEzLYw1HD7jB?=
 =?us-ascii?Q?7casZbeZ9TqBT99KHgPlzV7/sSW0nl4j2da/ZkYp8WwkQ3CQ4AF1FMiHrOcU?=
 =?us-ascii?Q?vZRSq9RP8dA1rgYL0NAuGPlxPS6pJ4+gRpvB+EaW29fVIFAvxIoP90HCMhkk?=
 =?us-ascii?Q?PBaXTrDq6C3lvasMY9kCIxBEM6+VzUYdeizyZOMBCOogyHTNnwsI8anndYsV?=
 =?us-ascii?Q?sY4MdNa23u0/PxGQ315bCppIWzkasJTtarqvR7NZz44s6UjUx34kozYcICo4?=
 =?us-ascii?Q?gA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5604.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799df709-a5a3-45a4-2818-08dd020d6de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 04:58:05.7574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j8IGyeepZgpjIoYQFuQyqGOw6xqJAqPPO8ao56XK4l6AUNj5nztEozlNvE9bmJFOa026ZrxSQj2oau2bTmAnQge5OppBO7X1Hl4wdtEZ6dtat2iy33chfJeVPqUrgpmP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4960
X-Proofpoint-GUID: 18JJFzr3YtqjCEb85EXQLsedsoytD1Jj
X-Proofpoint-ORIG-GUID: 18JJFzr3YtqjCEb85EXQLsedsoytD1Jj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411110041

> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Friday, November 8, 2024 7:43 PM
> To: Calam, Ramon Cristopher <RamonCristopher.Calam@analog.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Liam Girdwo=
od
> <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>; Rob Herring
> <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>
> Subject: Re: [PATCH 2/2] dt-bindings: regulator: Add adi,lt8722-regulator=
.yaml
>=20
> [External]
>=20
> On Fri, Nov 08, 2024 at 05:35:44PM +0800, Ramon Cristopher M. Calam
> wrote:
> > Add documentation for device tree bindings of LT8722.
> >
> > Signed-off-by: Ramon Cristopher M. Calam
> > <ramoncristopher.calam@analog.com>
> > ---
> >  .../regulator/adi,lt8722-regulator.yaml       | 178 ++++++++++++++++++
> >  1 file changed, 178 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/regulator/adi,lt8722-regulator.yaml
> >
>=20
> This wasn't tested, so limited review follows.
>=20
> Please use subject prefixes matching the subsystem. You can get them for
> example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory yo=
ur
> patch is touching. For bindings, the preferred subjects are explained her=
e:
> https://urldefense.com/v3/__https://www.kernel.org/doc/html/latest/devic
> etree/bindings/submitting-patches.html*i-for-patch-
> submitters__;Iw!!A3Ni8CS0y2Y!4oCmeTiTgVsrbS0h3A8z0TbxaKPm_GIn6rOz
> 8q48wWGHHDiFUnSbWQNtfx1s1okiqOIwJh-jS1S68-GRpPAtAQ$
>=20
> > diff --git
> > a/Documentation/devicetree/bindings/regulator/adi,lt8722-regulator.yam
> > l
> > b/Documentation/devicetree/bindings/regulator/adi,lt8722-regulator.yam
> > l
> > new file mode 100644
> > index 000000000000..3fbf788d4154
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/regulator/adi,lt8722-regulator
> > +++ .yaml
> > @@ -0,0 +1,178 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) # Copyright (c)
> > +2023 Analog Devices, Inc.
> > +%YAML 1.2
> > +---
> > +$id:
> > +https://urldefense.com/v3/__http://devicetree.org/schemas/regulator/a
> > +di,lt8722-
> regulator.yaml*__;Iw!!A3Ni8CS0y2Y!4oCmeTiTgVsrbS0h3A8z0Tbxa
> > +KPm_GIn6rOz8q48wWGHHDiFUnSbWQNtfx1s1okiqOIwJh-jS1S68-
> GzivZhfQ$
> > +$schema:
> > +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.y
> >
> +aml*__;Iw!!A3Ni8CS0y2Y!4oCmeTiTgVsrbS0h3A8z0TbxaKPm_GIn6rOz8q48
> wWGHHD
> > +iFUnSbWQNtfx1s1okiqOIwJh-jS1S68-E5-fGDNQ$
> > +
> > +title: Analog Devices LT8722 Ultracompact Full Bridge Driver
>=20
> Driver like motor driver or regulator? Or Linux driver? If the latter the=
n, drop.
> Describe the hardware please.
>
The term 'driver' refers to the LT8722's function in controlling the full b=
ridge
output stage of the regulator.

One side of the full bridge is driven by a pulse width modulation (PWM)
buck power stage, while the other side is driven by a linear power stage.
An integrated 25-bit DAC is used to control the output voltage.

I will revise the title to ' Analog Devices LT8722 Ultracompact Full Bridge
DC/DC Converter' for clarity and enhance the description with detailed
hardware information.
>=20
> > +
> > +maintainers:
> > +  - Ramon Cristopher Calam <ramoncristopher.calam@analog.com>
> > +
> > +description: |
>=20
> Do not need '|' unless you need to preserve formatting.
>=20
> That's all folks! More review when this is tested, please.
>=20
> Best regards,
> Krzysztof

Thanks, I will remove this in the next patch.

Best regards,
Ramon

