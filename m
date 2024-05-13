Return-Path: <linux-kernel+bounces-177325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A5F8C3CEC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C291C212D7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD77E1474A2;
	Mon, 13 May 2024 08:13:13 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2102.outbound.protection.partner.outlook.cn [139.219.17.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607E146D5C;
	Mon, 13 May 2024 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715587993; cv=fail; b=Eyg9r0O5AKbh7A8LlazEX0O7ZFb9qrL1UdFh+NNA2QRF8Uk34H6hGpmw5qs4NtC6LhyhsbxHgaPqQp45trTE5ApQ6qK+F97yclK1hzXDKWL1jFoLQBK+8mleWC56Sgp4RcL9BkcOOVAO7tt+bgpBsE8IXZ9bbQeTQwQLIBDrR/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715587993; c=relaxed/simple;
	bh=sm5ojYjqspJpsjBR6kXuJgzLIx9+kfcoRa2r0oD34b8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YbyuQVxBuTB3AJ2u0FOIvxhXfsTemGjkGjS1qoe/9GkK1JmHwFO14AUHiyZ9RfjCmGfbj5069vTV9DUh7HATYEicHxIf7IOGH+2UeoR55hAoI52D4ma/USBRDuOhvF94raWthId2tUDu4RC4U7rt8T2KeRh+HJbjcUf3VD3A1B4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPqembSEatOUbSAj6ejjHmQcl8G8HpxoRmFJSgHh7AYpFckKHN+axlNV9an6kcNHLoLH4uOM110FUV0DO9k9leAKbTiGfpPr5VCOd2cBGRZdsnUns6PgO2hcIK9CjB9BiOxX5l0rR3Z/qbmtWYdZg7xogD4ZBV6M8n4PBlLCh/m/o/FO2Q8EGHKvB3gRvQOZIV4EgYxkzdPNGLeXj9uuU7nvzFFBIkgKtjM3m5T1kuU0bctFSEPPhk5WLrmm4huyl0mBL3CoPuMTLgz1v+IXwoGV4+PTLtQkhj88v7rPxf9dIESCuJJw1fNk36YPehYwgRbw/+zQyLo037EPrVEKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sm5ojYjqspJpsjBR6kXuJgzLIx9+kfcoRa2r0oD34b8=;
 b=DOjMX8le6BYODQfLvsNHfxysi33gRzE6vjxbjzYsXSsO4rP7SAUTTo+ieXTBFIBGADpypk7UKnrG2ehSzN80uUHFJIF/aR3xshXwm63S5eEw+D0tuHMC8lb2JNVua7CPtrwjLkz/2QPeyCU3P8va6Gb4cNfzMc6BPi3FfkFzWRuq+miVfk7tAxnVfudv1GH9bxMSQJMJgBtbOtZUDUyRIXv4U0MPClhf/E+pjORoO/1chDW0gsMQETP5W3RM16MN7XsO2EhimkVqVdfWXK/mXgcz8GvxCNXl7bxVz+4Z8ERnbKlBbhLs9f7IrLmX7HWuZGmn/Hcz17Vl3vwQyY7Aag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) by NT0PR01MB1086.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33; Mon, 13 May
 2024 08:13:06 +0000
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::2bb1:5ec6:5260:17bd]) by
 NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn ([fe80::2bb1:5ec6:5260:17bd%6])
 with mapi id 15.20.7472.042; Mon, 13 May 2024 08:13:06 +0000
From: Shengyang Chen <shengyang.chen@starfivetech.com>
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>
CC: "vkoul@kernel.org" <vkoul@kernel.org>, "kishon@kernel.org"
	<kishon@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, Minda Chen <minda.chen@starfivetech.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>, "rogerq@kernel.org"
	<rogerq@kernel.org>, "geert+renesas@glider.be" <geert+renesas@glider.be>,
	Keith Zhao <keith.zhao@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 0/2] Add JH7110 MIPI DPHY TX support
Thread-Topic: [PATCH v5 0/2] Add JH7110 MIPI DPHY TX support
Thread-Index: AQHakUOQsqv/k7+taUGMK+CBBD3iILGU9kAw
Date: Mon, 13 May 2024 08:13:06 +0000
Message-ID:
 <NT0PR01MB1070236E5E5FF0F0223ED81BEFE22@NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn>
References: <20240418035020.47876-1-shengyang.chen@starfivetech.com>
In-Reply-To: <20240418035020.47876-1-shengyang.chen@starfivetech.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1070:EE_|NT0PR01MB1086:EE_
x-ms-office365-filtering-correlation-id: 6625ac71-96ed-4156-f69d-08dc732484ae
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OywekNV/mVaY28KKub094fol+2aMUetqbB5j5sKXTI08EU/bBYiZge3RMoa3sQZUXB22NsrdsRnwyL5rb1hkmcgRo439E0DChRPoYMrcKylWXPpWaYrO2Cyr4iNfiv3CL/dZFQ5SPY1R5AOKp81BFrEdAx1yw0CgXJgqExqm1ZBB0aNAJ/uplBSq03nyVrRHUreYoXXFtrBPIA3JpXdWgEY9ck0IwnANgbbReb5sDt4emj3vm3yjfrfqv+qsVxP/Qz8nTnOA0gmQaY46pem94upjkaYYanGfmCsNl5Kwj8VL0l3zTu7MroHjR8e1lrxabHL17IM56NkNbBEcLn6l3AnllR7zXV0QJ+dTXyjZ3Kon6SKXvr+Zw/czX2zgRYNiDpMOTh7Zfo+helSCUYMqDfztoJrhanCWRf73xd4qPZfOA0ySTaD/xc0rWVrH1ZwpcFZxjE7cWZ7tyMZRqUp8kN+kfRkv3NSoSNPs6FL1f7urL0lFhV9rSF2I/1dGwO31mK9aF/q7PqwS7ZSSUJigLNsAKx17S9mIf8mLP9FO9WeZCPARkaJHrrPv4DH3Q6qDyNK0DYXt+ujtLmkv4Vopr5YL4oEETva4YcMUTWELxszQ1N+Sx+xM6HeEe89U+ceL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(7416005)(41320700004)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?95gZM4Omj6/arFy7g+2NrwK2iVELIXAdE/P2XdvftnT9PKTlgn8daMgWOB7z?=
 =?us-ascii?Q?qwtiA/9tkbYhAx2d85S1qfs7Sq5WwgLJipGuvD0Mr6B/V4BA99N304nfKELW?=
 =?us-ascii?Q?jEQQNqQUMGWlM8HdqtAO7nmPCimb0gHmzY/HjlGBAZiu0MArHpfiIAN6nVUI?=
 =?us-ascii?Q?XrO6p6wxdJCZY5qvVjq82Q5sHovyxJE6LiIcJRdGtO8GyjzgJJrS3RwllSTT?=
 =?us-ascii?Q?u2qcNpRU87Brmy/ZAw61VJoDNXUNiWLaDAIYbLw905VCltmUjRR+cp8zmUyF?=
 =?us-ascii?Q?ZNaNrl7oXppAlwvH3ZOfsfRegHLUTOx98Vr55ngUkVNvijlHiGfyWNi7YoU4?=
 =?us-ascii?Q?12MwG5FRjeyJgXZAU46hQ4OlqS33m46FABdPk+m3s9+krgzEzCUCHd0MOQVj?=
 =?us-ascii?Q?aB/CPvbcBxhSF9U8z32SPzYUhoBgEGUtqYvR/Gr5zqNi2iI4p8UmSnHe6S27?=
 =?us-ascii?Q?xC/Lo6xWIWKV+A5/+jL3aRK54Tumij8PGkVGPmGI7qchrxdGQgV4SrsUOGI7?=
 =?us-ascii?Q?m5yHAxHt4HmFxXqSShtuyx7kF8rcJICDQmol92D3uYcDSdD/v62q+btAw/Jt?=
 =?us-ascii?Q?viQEZzJoBLGWXrcaGqSAtjLYZK6eyFkvcRsbCRVq5Ufx5gVE8Fw+lWK7OsKk?=
 =?us-ascii?Q?cT0YUjwJ1rXNQowcSmhJPkWsSU05Dc7iqAY9YXN3Q0sOobYknDnmVxNpGniq?=
 =?us-ascii?Q?97wGDbNwnnFyQRKPUr9s3KDLWKAr9zXP0QPRDDcwSSC8CWZajJQkKB+RBUmI?=
 =?us-ascii?Q?n++NWVIeNX/xdiDnr1kGGvaDsH21JLoD8eoxk4YdNMR/E3g/NGZhwHTV33pm?=
 =?us-ascii?Q?r0sZ1Uaxr41gNkziGdN5BmrpKxd1+gIO9vNux+gXv7adQCPFjU+5Een5tB62?=
 =?us-ascii?Q?5WHWU2ch21HExtn/MESYUaGkNwbYGn2fpyWe73u/JiFX1wIOmAN1gPprqESK?=
 =?us-ascii?Q?pc7mMs9/i0mF5o0BkP7y+SuLJ++3usiA9oXAK+THFI9W3D00Bk8PzGDSNcuA?=
 =?us-ascii?Q?cRE4excZDDqtJQZo2MUcJjHf99ypmELAI+n1d3ej/Pzd63RCSDFWoj/tzmQ+?=
 =?us-ascii?Q?RyMVyUqMwKAu6+2V1poVdQfwn2KPT/MNKQE7NEp5ZuT3tU40tZVSRrUBilxQ?=
 =?us-ascii?Q?FbsX1iV58wmM1LdjIQMR5+13uqXMV2MQUqKbfuGGDGFyKUe8+cjyboUJDHYR?=
 =?us-ascii?Q?JidfJDH2s6YaduGxLsM3PSyR5mD57MV7cAlFy91XCQ6NkLWVYiNvrl3ASPKk?=
 =?us-ascii?Q?Ufxg56dUpdO85I2HWuZmRcbpQjCSC3xSPp6/fUBj3gfvhVIJICGT6SRXd9oJ?=
 =?us-ascii?Q?5+yxu7Yfpo2fTaxwkzykwXFhPESzw3P47p5q5SwWWA7WNsIzQjCypyZTEkbs?=
 =?us-ascii?Q?Vf3o/ojqjnaHfIzjWcN1jRP+fBDjidl7R32IwNU3D4LbaH9Di/uCfL071UJK?=
 =?us-ascii?Q?ldDmrV7huXZKYOnzPyngsysQCg0uPMcs5tK3W+T5uQPjZP6Au+qFio+qOt3+?=
 =?us-ascii?Q?H4/ZHexTdqI93sYdrm6EHcOjBPr1sDKgyyKqP0V3Vv+0MiPtIea9zSAjXQm7?=
 =?us-ascii?Q?REwtgZhHUQVwp/5QbcP0qEuRnIMtEc8b8U6Oyw9WtdRhYx/14tfCZMBTP7jK?=
 =?us-ascii?Q?BQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 6625ac71-96ed-4156-f69d-08dc732484ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 08:13:06.1592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6xf+n4tXWoFxWNiiael/vzs2j7hcga80T4TWSw+2zYHKp4R/BbgWoJwbO+82zF9HmdQlcC2yVXky2VHVcw4ObyBDM7hx8QTCBtS74HMKhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1086

> This patchset adds mipi dphy tx support for the StarFive JH7110 SoC.
> It is used to transfer DSI data. The series has been tested on the Vision=
Five 2
> board.
>=20
>=20

Hi, Vinod and Kishon

Could you please help to review and give me some suggestions
for this patch series? Thank you for your time.

Best regards,
Shengyang


