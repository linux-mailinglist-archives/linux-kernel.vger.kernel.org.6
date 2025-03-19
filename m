Return-Path: <linux-kernel+bounces-568635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D83A698AE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06905463FF4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D626E20AF71;
	Wed, 19 Mar 2025 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="r1g/wOmq"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74320AF62
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742411180; cv=none; b=oppjvj8DTv7YsQzpoyi4jX+1GWB83hu4m2xQIAHUJla5DBdFMuLoS5+NY/bvrHHBY0J9cekPzASFNm2kqOao4MGi310VD/TWkCuWA+NZi318WPxY+RTUpUeSHmi/r/cqaU0u9XHgCTETV6yKng+UuR1Y1ykv4GHHeI8V+nzb87o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742411180; c=relaxed/simple;
	bh=tGDrPL99iQCZY/u2/xPnK/pCgW93vFWfNo6h2UP703M=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:Subject:From:
	 References:In-Reply-To; b=L5BsBRI5WQ6+G3abEEzby5DUEo8PCWIvHkbeUvx3GO6BGsPW8NK4biiKxl6iyrILR/r9/5VfokNI2ELjYwFFVQ/hAPIXuk8WD6b4S4MMphx4mvjqKmDJhhfqSbenPYkGhn7bqSxk3EYKtcBH0LYbILO0zMAuBQxEy+SBDtfSlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=r1g/wOmq; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1742411176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHQ3Ngz9cNLQIGQBw16DZBzL1L0whpDC6ssfPJFBJJM=;
	b=r1g/wOmqJPq1TMuu/XCjqxm9Zku1seTSsX6OX+DmtuZzslvAmn8XspEXWuAWAnV8pZUH2b
	8FpgGcss8pWSihofzHpqjjwfaxTyGbWOx9SRDo4EF7NAeCto+FkKzNlQbbn0kU7tclV5hC
	HeiSHhvJwdc8dCNe8d1CnhwodWoodcY8B943c9p3133YtvVPO4DytPy6p2Yhy2HmDXubJN
	4IrGwM6I6tFXhpo3nGHQGQVVmd8AA9hdYPtJeXPjeKhBGQzCETL0ojpWor9CNcLTvFZ4wm
	ZpEKg0O+aoi4pjxU33Wy5dr5kuVw5furP+u32rKisVFNDCAwA4/MBsvSfWmkKQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 19:05:50 +0000
Message-Id: <D8KH7CDPMWDS.396O6X214BX59@postmarketos.org>
Cc: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
 "Artur Weber" <aweber.kernel@gmail.com>, "Karl Chan"
 <exxxxkc@getgoogleoff.me>, "Christian Hewitt" <christianshewitt@gmail.com>
To: "Ferass El Hafidi" <funderscore@postmarketos.org>, "Neil Armstrong"
 <neil.armstrong@linaro.org>, "Kevin Hilman" <khilman@baylibre.com>, "Jerome
 Brunet" <jbrunet@baylibre.com>, "Martin Blumenstingl"
 <martin.blumenstingl@googlemail.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH v5 0/2] Add support for Xiaomi Mi TV Stick
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
References: <20250319190150.31529-2-funderscore@postmarketos.org>
In-Reply-To: <20250319190150.31529-2-funderscore@postmarketos.org>
X-Migadu-Flow: FLOW_OUT

On Wed Mar 19, 2025 at 7:01 PM UTC, Ferass El Hafidi wrote:
<snip>
>
> More information is available on the postmarketOS wiki page [6].
>

Which would be https://wiki.postmarketos.org/wiki/Xiaomi_Mi_TV_Stick_(xiaom=
i-aquaman)

Sorry, forgot to put the link.

Regards.

> [1]: https://lore.kernel.org/all/20250203174346.13737-1-funderscore@postm=
arketos.org/
> [2]: https://lore.kernel.org/all/20250203091453.15751-1-funderscore@postm=
arketos.org/
> [3]: https://lore.kernel.org/all/20250201193044.28856-1-funderscore@postm=
arketos.org/
> [4]: https://lore.kernel.org/all/20250131200319.19996-1-funderscore@postm=
arketos.org/
> [5]: https://lore.kernel.org/linux-amlogic/20241227212514.1376682-1-marti=
n.blumenstingl@googlemail.com/
>
>
> Ferass El Hafidi (2):
>   dt-bindings: arm: amlogic: add S805Y and Mi TV Stick
>   arm64: dts: amlogic: add support for xiaomi-aquaman/Mi TV Stick
>
>  .../devicetree/bindings/arm/amlogic.yaml      |   7 +
>  arch/arm64/boot/dts/amlogic/Makefile          |   1 +
>  .../meson-gxl-s805y-xiaomi-aquaman.dts        | 292 ++++++++++++++++++
>  .../boot/dts/amlogic/meson-gxl-s805y.dtsi     |  10 +
>  4 files changed, 310 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805y-xiaomi-aq=
uaman.dts
>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805y.dtsi


