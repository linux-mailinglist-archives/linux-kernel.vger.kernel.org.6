Return-Path: <linux-kernel+bounces-189305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9910A8CEE33
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 09:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31804B21C80
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EA0182DA;
	Sat, 25 May 2024 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="XQIGJ2wW"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804A529A1;
	Sat, 25 May 2024 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716623761; cv=none; b=MNeTgCRY8ISL6eCQ4HVwETclA76/Jo1w7RksgxC94KdFyoUx4zj56QKwvCBXmU0xAUIfbz2WBJzpFSuZVX7NJjla9/rE/eW1OW1p0QId0QfytvQJ5p/iJCUtzQaV/v3QP61Kht9hHjn+FfvZ56jYXzqRkxGBqbudBBIbQ1AfHWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716623761; c=relaxed/simple;
	bh=zNvagCiFQlEBJ2V2WaqD1hNPPhtIuYBADiTXOIv4iXo=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kzIc2X9FT23GNms4VH/2zzg6XNVKUftrR1kiEUEBoDuE5c0EqGq5h5m9wf3+dg5mN/VXPGmNcLxn+SUCyT4rNjApBFRnCCu8HLmS6vcNI8rAmgW+U6gLJPIDpsLpf8QDvkvyUOxEt4Ib41Omf6YlGDg/W3q/rX5DzT6xI9F1vtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=XQIGJ2wW; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716623731; x=1717228531; i=markus.elfring@web.de;
	bh=zNvagCiFQlEBJ2V2WaqD1hNPPhtIuYBADiTXOIv4iXo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XQIGJ2wWNkooZLiH9ykL+s9D1Jp/h7XyOyIqB4B/ZF4156HUTr6t5/QoSOnPUP+i
	 69tO954AV7XBmj8M1iIrJo3/G+KObqUk4qHrIxOXjWS8NE/c0ZMTkDwstITEVnPtk
	 hZ3Bp6kzAnAE2aohz4iOJQiZdBPqpDpaTJagrTdKjgMIYXOSV2XO8P4/gQ1QzbYeL
	 9Fvf0Plrka8SJfuG+1YWHYJSokJMR2qgA1PQ/DiwVHjW21mQckHdKtAzmPaFPhEI7
	 3HOZT1XxVuhieJzGX9hPwsEJ718TLCrnoPHzmEmMzUjvQwth85u+rHPfBCXg2mnh9
	 WpK/nE7TBQE8U6Iqwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5CQT-1sbyAY01zR-01166w; Sat, 25
 May 2024 09:55:31 +0200
Message-ID: <9fe12ecc-c4c2-4adb-a62c-4c8fe91b6613@web.de>
Date: Sat, 25 May 2024 09:55:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel-janitors@vger.kernel.org, imx@lists.linux.dev,
 Abel Vesa <abelvesa@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Fabio Estevam <festevam@gmail.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Michael Turquette <mturquette@baylibre.com>, Peng Fan <peng.fan@nxp.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Sascha Hauer
 <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel@pengutronix.de,
 Shengjiu Wang <shengjiu.wang@gmail.com>
References: <1716458390-20120-6-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v5 5/5] clk: imx: clk-audiomix: Corrent parent clock for
 earc_phy and audpll
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1716458390-20120-6-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+Y8RZ2euW0PVsjjmirk2PPULrmxZDg8ex4ooenqfMi/uUTvAPbJ
 97nEDosbWPobp6ainbMMsYAxR/DSRSHyRVrqNoPpiPQ8W7nJDlC7hNa+O2dD3Yxx+SfZYI2
 WaZIj2Z1bIO8c5T5GIaqtSw7g27d+0I5sQyS6ADMV/tuRHY5UI2iDweRETxL8KMVflWICpc
 YGJznrb9DtsaDJOmL20oA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1d1X/haDOVk=;YgC1d6or9qyXrEPVXDekffAk5nE
 xj2NyIa/QqjwbTI3z3wyAWSGSbiKebbbVBTiDB+2ysc7F00bHcnrX+WVY810vkXgVMrp1Iivx
 l0dH480jOgsK1EeSJp0jV5PBB7YlxfGz4jtZW2uQopt2yc7v1YA7I8TtG2CfF8Z2p3oiKChno
 jT++5rfnI4Nqfr41ekSXGap39/lxRUnDGqdP2fD6a3l8Ca/oIW2yBbD3qkSjCvnOu3eTkNMM8
 m2gdjSpTf7PK0enARfGhaUT+nEmlwbNPFqpGxBwhR1yvbqmdaWN+Hjf51ns8QE3XxRXswYW0X
 0HbzcgcZOsK20+XFB6VwP+N2tbEZB8nX8HsKPm9mpDpc4rznXzoDH2gSZenIWVGpiRsPEl2o8
 OTir4qDjYAvmTsZZZGrXGyBZfmyw3i0w3K6aVvNFNdDtFghNHtP2tQkzoqPVVp4vHnXdQdLUK
 0qTPq/Lqk7a56PlJsZkAAK02//pBCY/G+kNyW1FTrVn231BmJ+VKYgzY1IH0EB/J41ocBQanw
 VjyutO7nEb+UiKJocyYq2N+oZ3DI0NRb7o7EN3sKfcQpPLR/OJg3nYa2d/mKUSfbltwZ9gUkQ
 lG1TW33UZTMC7FlXxR6PObEsOpHP5QyJKVVDP6HAa8a00E8rpKlQtAjHPtlj6C7/QLzk4cpPS
 OPXgI8VDfaMZBwNjWGXRJFmhtR4DGt9wW1zKtoitjkD0t8y0vfwXZBIslugoJDYE9CsAKjh6i
 i5XwRrK2AupGJG8s/UuuCibG4YZVc5prnsRhE/3tE9zjkLk/NQanaFzX5b3IRQccZQrhafcul
 2y/T9RH4Yh0h5j+hMvkwnTd6cAHqiJnvndHsi/p8SDnxA=

> According to Reference Manual of i.MX8MP
> The parent clock of "earc_phy" is "sai_pll_out_div2",
> The parent clock of "audpll" is "osc_24m".
=E2=80=A6
> Fixes: 6cd95f7b151c ("clk: imx: imx8mp: Add audiomix block control")

Does such information indicate that the word =E2=80=9CCorrect=E2=80=9D wou=
ld be more appropriate
(instead of =E2=80=9CCorrent=E2=80=9D) in the summary phrase?

Regards,
Markus

