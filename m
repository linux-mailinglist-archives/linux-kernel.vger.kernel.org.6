Return-Path: <linux-kernel+bounces-410117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5696B9CD4D8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 02:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05729B23F09
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABB340849;
	Fri, 15 Nov 2024 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jpwIXWw9"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F791370;
	Fri, 15 Nov 2024 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731632443; cv=fail; b=Q50d+9QOQ5XOMK75kT6Bh9/sFPWCcF3YK2ZKb8iEraKEb+Jrjh+YJNd+MghlyF0Ve+aduqpGbDAjD2cOxLw5L6a8ovzcbGBsFxW9NQJttVpRqgP5EIM25nHB5sa7pff+8o2L1hWP7+B36+nTmA/Do/Zcq8xYjwqmOnAnEoE3K08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731632443; c=relaxed/simple;
	bh=3rKkMJyawofE8zG99dZMnousqHLul8NK2hAJVKC47T8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ecjVPPBAstLGyliTmA/G0jpfK0r5hIN1vVwrBV+1HZZCiCBSGRRUUF9FgxCFdjyoyI5THmK4ZadkhY/DNMIDWzT1V20B5caCgMmnVORQPnXS84m7jlrcNOfXUmHHFlXovZhhb8ToFFcd7vY7nufN3oyU78daB3TAneT331CxU/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jpwIXWw9; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEK4YaD006012;
	Thu, 14 Nov 2024 20:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4oG58
	IQ73zGOver0CgSfsa2zljK3iZw3wtFFvgJLVP4=; b=jpwIXWw9nJDmxqdMapE4g
	LEE26jSJ6zBoKIjhKtjFhOcmlAxu2P5h+djRPH1pjNWbwZo73x0Whi2DtzQhwfl9
	BI9RNDeQ2mmOLKYYweqsD+vIMxtU/9FhjbkxGROJFSPdF5tu1Npf+Ne7ZexNos4E
	kHJwsCwD0DdWXX53660JRLArOZvx6qyCeG8uZpJAOQGznsQs9y0CtnmHS2Ed+0mM
	LlSEJ/nI8IghqZRTxOcDQTj+61nkbpxpLjXnlJIseJ7Xay0wc0fR3LhAynPIdSa8
	quevs/1gJz7JgE6LxWmN7KV44L2ww+Kt0WRcHCHrugTZoIdrbLUNpBscP33S5Wfr
	w==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011028.outbound.protection.outlook.com [40.93.14.28])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42vrwwk409-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 20:00:24 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEpCTLNZQtN6NmIZ+vPJBFVn3ch+D5pgoTTk4EJLtXVSDKIHrDlS9LChV7T4T1GvBZkjeHCS/eRonpr/j0rVh3ZGVEo1tzmzz6EevIok8wuDaDmSrnFAQLihm7jkLdo5Aj4wPDTOkT2QY+UiOdTZDYyfILfLaRIZtq0v/+1qRQ2od3beJo4vRhVM6UHHxWdZz+ht/0YdPsNKQCkUluc0xaQ5b+EKHVFn2EnfxKMoa98Zhh0Z4BLriHgf4N+BqHj5HHsp3/jKbWo8rlW4WC6tR9vp46hY7JFNCZnhmP6QKDGcjwnbfHcKN3SdtLAdwu3GZ0IKYXJVQWLhMOlfTQFX/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oG58IQ73zGOver0CgSfsa2zljK3iZw3wtFFvgJLVP4=;
 b=RCSzfUUt49U8zdCW6RY7dpnHxDJVM+aQf5rg2foh7HzIiomMJEuSXK7dxAfPT+nJrEzFxSu9UPk21L15fZUOPtViRghfcjG8pVwpCRSoFs9Zw3E8xIPQmJw/XiPhYp0tKlvqwIOqzz+nv9spknZw4ueaLq4XymuxtlVr3HLxnZ4ZphVboOyMG0T1iKPvoe0qpnt+somExnBWwknukaiIEevOIFATj6qJgbPnjonIDUSNcPSCmArwTVG7eg5R5bQTW958x3aUQvf0MKEVxrzfh8pQJMwsCdy7Euo0YgYK26/YuUPNyl/BB8gzmPuRkGCq3B7MLLbuiHyRN6DSKQh7fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from BLAPR03MB5604.namprd03.prod.outlook.com (2603:10b6:208:29a::12)
 by SA0PR03MB5580.namprd03.prod.outlook.com (2603:10b6:806:b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 01:00:21 +0000
Received: from BLAPR03MB5604.namprd03.prod.outlook.com
 ([fe80::3c24:93fb:94a7:241e]) by BLAPR03MB5604.namprd03.prod.outlook.com
 ([fe80::3c24:93fb:94a7:241e%7]) with mapi id 15.20.8137.018; Fri, 15 Nov 2024
 01:00:21 +0000
From: "Calam, Ramon Cristopher" <RamonCristopher.Calam@analog.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: RE: [PATCH 1/2] regulator: lt8722: Add driver for LT8722
Thread-Topic: [PATCH 1/2] regulator: lt8722: Add driver for LT8722
Thread-Index: AQHbMcGjKrPZHHPhVUmEJqa+GKa1wrKtVj6AgARoqQA=
Date: Fri, 15 Nov 2024 01:00:20 +0000
Message-ID:
 <BLAPR03MB5604248B31390D68AB180D8393242@BLAPR03MB5604.namprd03.prod.outlook.com>
References: <20241108093544.9492-1-ramoncristopher.calam@analog.com>
 <20241108093544.9492-2-ramoncristopher.calam@analog.com>
 <2cce3ad8-7a3a-47db-a18c-33c32e96c009@sirena.org.uk>
In-Reply-To: <2cce3ad8-7a3a-47db-a18c-33c32e96c009@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BLAPR03MB5604:EE_|SA0PR03MB5580:EE_
x-ms-office365-filtering-correlation-id: 9e57ffdd-d1b2-4503-d126-08dd0510e118
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mipo4t1EK9nE35XQRFnHB10N8vsk19xahTUvAwb8KUeLr247I6bWSumn2mq+?=
 =?us-ascii?Q?Rm1xrEjNv/5PJdMR3zJJzBM5XSX9sXoCufjXChAOa+fij8OhOmf/E9dP+EvI?=
 =?us-ascii?Q?MthQnn5sBww5e4+XM1ntr91zb1ZnEmmSPXvr81ddT1HGBBGfJNlGv0OPGQL4?=
 =?us-ascii?Q?SgpUII10RLeIj1sB/PbndCzQrNYNhTWwv23dY+azZrWezySwc0ttnDi3g+wN?=
 =?us-ascii?Q?Yk92rM8Uf25QLVQyrlrSmNMxbV7K+XVzmpiy1VX3MjzKeMe8Pa2ZwlR7rSEH?=
 =?us-ascii?Q?MUakd1DB12p319HKfT44vpKeX8VCkjThiSrXNPjcblFJyLIlbYFoE2fc1moo?=
 =?us-ascii?Q?W0PYwZYmGhi88xvslkk4bmMJwuD03pF8c25rr/lP/9ELDDNDujnHZ/Z+357i?=
 =?us-ascii?Q?5aOOUwUiy8ZfH8gzkosBp3Zx+RtdINDz+igTLJtF9xEi31i9AqS9ek+kiOnJ?=
 =?us-ascii?Q?FKfkGm2GbEHzrHAadtmhXc5mZZJ3A1Q+juyvyaNFxwsOgWRZVr1r0Ldu2SYz?=
 =?us-ascii?Q?5jY3cCbw14I6xvp8VGMaYkZypFqMwCV4PHUopGcMVWjrJAhnx21tlZ6JJ83N?=
 =?us-ascii?Q?wYEzT4OOgV6zWcLyuvrrblF/ykbi3He+s0GXiyd+qVP23BL+5O0tftc0zQb1?=
 =?us-ascii?Q?gF4dYw9KIjfb4YouwoQntuZaHtNKyiTTwQAdH8RM5nE6nG/SUx/I273JQ6FR?=
 =?us-ascii?Q?1SzM4M9PBRl2Lwdc4TKgb8hUVL4HKEyiL4bcmUtmuhvhhoavDdlaC0n77RFy?=
 =?us-ascii?Q?qLgsfgxKYxkuU3mF4nZSO4qP9bz81qDugx38ic0vU9YgmU0r1OIItkzmYHid?=
 =?us-ascii?Q?Cou/k8aZMidBrQiZFG+Ex/1stzymCjHmGnQN5pHQ2NQRBVSPFvkEQKJgAnRb?=
 =?us-ascii?Q?49bKuXI1dkaWvOcJygiTd0etdmSNoEDQdXpgZn/gzXBgtxgjzTTzRhzge1eO?=
 =?us-ascii?Q?1k63tXU0vzfycIgjiVvurkTWkNAc1u0Bw8xfWmbNlpJ87AUvSySROsNTTIL+?=
 =?us-ascii?Q?9vhPkIjFy/iomznU3ZkeKuy+kSa8un8lshZXOcxe5JT7gfj/JAz1clYWyr2P?=
 =?us-ascii?Q?pBC/rraLzIORmfnz9I1RYdKPjCM9Q5DbrJcHKaesysnmGxlraFT9mqCzUHwf?=
 =?us-ascii?Q?RJ9o4bmhFlcHHC1JXzxJ+tV339aGvpQoOPB8PId3f5mF8qOZuZQw+chu6q8L?=
 =?us-ascii?Q?o9sY+4ajXGzYnN8x6pKYnE7RbUZtM4o2O2YBQlOAKk4wmhD+TMBqsh/mnOF5?=
 =?us-ascii?Q?KCvqk+0yxllNhWuM6zIlEf7QGL83rjYB/L4Vpd3ewF16CyxdM3T08JhMP0XG?=
 =?us-ascii?Q?khNjXDIJ/m65v8kUPTk82TiJO+JTOs3BiGTY7l94ZEZcMJ6DIv/VCg+or6Jq?=
 =?us-ascii?Q?sq4ywKY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR03MB5604.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?J14v5OEOLMYyW8xRZJnCMzPStVF/ChPPIk6JQ1pkVWPxGUdDuxS7BZOujfUl?=
 =?us-ascii?Q?6hep/2dSGhn8zPfWJ3SVxOH5MSLu+5jSIQzxAxDvMlH9Tp87WW3FcnVs3E8P?=
 =?us-ascii?Q?mPdYEaHmpD4hcb4Rwr7If8uY6vHT9/xGERvA/2MvD+SB7dPE0FmxgJuflZbs?=
 =?us-ascii?Q?n/A+PIc85QpokpTzZ1toIAKXeDJ7+tpNGEHDYtRX2ZVFnr977WN/o+V55Gyu?=
 =?us-ascii?Q?b39jSYdL7Pg8pRbGeSAMca1B9IJBD1nOhRAV/QWakzg1FxzWuANbIOvXsaAe?=
 =?us-ascii?Q?4ycrNojRd+CKjT6XPw3zx7lxmjhJSAcAWbrM/S+kwJ+NgbBd1kAXG4r0vCtR?=
 =?us-ascii?Q?OkouHsw6T9ZFoi9kmB1dSrnXXjv951HHeFbe0Lmis+WKvXzeD3aJUXGzO03Q?=
 =?us-ascii?Q?iAUl6tpGlKgtJHPCsnoC8LuSRxefXFdhdpgoAFFHFATR7jVpr7sl/4A6WHJh?=
 =?us-ascii?Q?dZ69QavTdywcdpkplCyTz284g2S8Dndj0Qb5hasX+Uqae1X9e8kfoWa+mmLb?=
 =?us-ascii?Q?n9ThsUfdOKQFl/+tPPMbJuwpCzHk6H0DlO5lbYE8dU6knxsiYY4Xi/gGDo5E?=
 =?us-ascii?Q?RSejXhucUMNZBRAcivKMV6G2WJpCa/A1aPcapxmA+AKNZodZ+UXgzMLfwby5?=
 =?us-ascii?Q?83C1lAoXoKkVSqe3VSuWJdqr3dDPj90RKvyppurxnHW0YMGZ0uFy0umMXZE6?=
 =?us-ascii?Q?F8gsSVKbdnBRvtUdl81fUiUl/VYFTfjEYnAyaZ4+vfk9UA9+zadFCEdCbaXX?=
 =?us-ascii?Q?7G3DYl39Sun5GjQhbavZRlMFt5WNbUPr/kRmvcVhrTq3XSolaPf3Ozo/PB0H?=
 =?us-ascii?Q?cdAIAWjrYdhsASjj3V97ceWshaIKUEOxOdavS7N5/7r+HqBo0dvX2d859r6n?=
 =?us-ascii?Q?aw2/YlmwR7yRE9sQXDToERYFqmNR3JPrhyF1x7fyGgGHkERygDMGGSybd5Jt?=
 =?us-ascii?Q?HmEEucBEhMnrNoFGteYWEWTnwHdBRYIR32NVBH+RWh8mqakitHeCV4gd0mVj?=
 =?us-ascii?Q?T4gOGWKX5yFRrhjssT6nOA5YZQ8+qB85j8m9HVWqlfN41j5ywV9jZM+P6QS7?=
 =?us-ascii?Q?P7GJ+3pF+A5TRLYzRyH5fEpZJyWfBFVLAHbAB2bNMEfBe8471c9pysroAcI4?=
 =?us-ascii?Q?E6DSJHwRkBKGQGhT1DBwGCMpy+8+VB7bvXxASL4+7+0SLOxwOjXmEKCL5crJ?=
 =?us-ascii?Q?fVPT3YBBroeISmZ6OsoJ3rN3MKjhrRhZgfWLX/M7HiwbjtZWT8jC5JFn4v5V?=
 =?us-ascii?Q?I9xcqgqv3c9/ZKj85an7cYg2zP7qw9/emLgB4KsYAQEaughEXKFJHIQDV/eo?=
 =?us-ascii?Q?3J8sIv2RIXb7Bvg54swskzpY8YFN6zZBWyIzWWJdNVPOGWgonPDc7BtlYvKu?=
 =?us-ascii?Q?v9ZfVqvnnM6QXWamhCallAHzEpU8xoxKqDMl5tMu84/w4HhhxPR9q7btYz6h?=
 =?us-ascii?Q?KGMMLFiVFtnDBj/XAgiREiS/jvMW+mQ5nYVDo7tLl5nUQDNv9amZMSPbytHK?=
 =?us-ascii?Q?o8UY7no+3u4kFa+rKDGMV6hv2WtUO2SK7ASswcjqCVptmOJZQ6/3GkgBRyNS?=
 =?us-ascii?Q?0cYvmMmz8rekmuGjEEwFQi4myeMneymPPuT7nq+H0TcILViXPAQhryM6d4Nq?=
 =?us-ascii?Q?lQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e57ffdd-d1b2-4503-d126-08dd0510e118
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 01:00:21.0179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pA1lDnZrAtgqL6Ucj5W7kswYyLFu6WYLsnG4s0YQAI/mbClwEshDmx4IzYBBBTFKQaAi3I3y4a7Lynb3d3uIjjCQPKkawobKULZ0w89DNqg+F5Kau53woRO3cCZhkQc+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5580
X-Proofpoint-ORIG-GUID: zrs3P8Sjc6u5JzqyzydKrcleNZMAd3tA
X-Proofpoint-GUID: zrs3P8Sjc6u5JzqyzydKrcleNZMAd3tA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150007

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Friday, November 8, 2024 8:51 PM
> To: Calam, Ramon Cristopher <RamonCristopher.Calam@analog.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; Liam Girdwo=
od
> <lgirdwood@gmail.com>; Rob Herring <robh@kernel.org>; Krzysztof
> Kozlowski <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>
> Subject: Re: [PATCH 1/2] regulator: lt8722: Add driver for LT8722
>=20
> [External]
>=20
> On Fri, Nov 08, 2024 at 05:35:43PM +0800, Ramon Cristopher M. Calam
> wrote:
> > Add ADI LT8722 full bridge DC/DC converter driver.
>=20
> > +++ b/drivers/regulator/lt8722-regulator.c
> > @@ -0,0 +1,701 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Analog Devices LT8722 Ultracompact Full Bridge Driver with SPI
> > +driver
> > + *
>=20
> Please make the entire comment a C++ one so things look more intentional.

I will implement this.

>=20
> > +static int lt8722_reg_read(struct spi_device *spi, u8 reg, u32 *val)
> > +{
>=20
> > +static int lt8722_reg_write(struct spi_device *spi, u8 reg, u32 val)
> > +{
>=20
> You can use these as reg_read() and reg_write() operations in regmap whic=
h
> will allow the driver to use all the standard helpers and vastly reduce t=
he size
> of the driver.

I will implement reg_read() and reg_write() operations in regmap to utilize
the standard helper.

>=20
> > +static int lt8722_parse_fw(struct lt8722_chip_info *chip,
> > +			   struct regulator_init_data *init_data) {
> > +	int ret;
> > +
> > +	/* Override the min_uV constraint with the minimum output voltage
> */
> > +	init_data->constraints.min_uV =3D LT8722_MIN_VOUT;
>=20
> Any modification of the constraints by the driver is a bug.  Adjust the
> information the driver provides about the voltages it supports if you nee=
d to
> do this.

The device features UV/OC clamp registers for setting the maximum negative/=
positive output voltage. I've defined these values in the `adi,uv/ov-clamp-=
microvolt` property within the device tree, which necessitates adjusting th=
e constraints in the driver. My idea is to utilize the `regulator-min/max-m=
icrovolt` property instead, thus eliminating the need for manual constraint=
 modifications. Would this approach be appropriate? I'm also considering ap=
plying this method to the minimum and maximum output currents.

>=20
> > +static int lt8722_is_enabled(struct regulator_dev *rdev) {
> > +	struct lt8722_chip_info *chip =3D rdev_get_drvdata(rdev);
> > +	int ret;
> > +	u32 reg_val;
> > +	bool en_req, en_pin;
> > +
> > +	ret =3D lt8722_reg_read(chip->spi, LT8722_SPIS_COMMAND, &reg_val);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	en_req =3D FIELD_GET(LT8722_EN_REQ_MASK, reg_val);
> > +	en_pin =3D gpiod_get_value(chip->en_gpio);
> > +
> > +	return en_req && en_pin;
> > +}
>=20
> Always adjusting both the GPIO and register all the time like this is poi=
ntless, it
> turns the GPIO into just pure overhead.  Just use the standard support fo=
r
> setting enables via registrers and GPIOs.  When there's a GPIO leave the
> register permanently enabld.

I will implement this.

>=20
> > +	chip->en_gpio =3D devm_gpiod_get(&spi->dev, "enable",
> GPIOD_OUT_LOW);
> > +	if (IS_ERR(chip->en_gpio))
> > +		return PTR_ERR(chip->en_gpio);
>=20
> Presumably this is optional, it could just be tied off.

This is currently not optional but from the comment above, yes it could jus=
t be
tied off.

Thank you for reviewing the patch,

Best regards,
RC

