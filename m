Return-Path: <linux-kernel+bounces-439206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0875E9EAC3D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B27AA28FF73
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC5D78F36;
	Tue, 10 Dec 2024 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWGwe0BA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A6B78F2D;
	Tue, 10 Dec 2024 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823108; cv=none; b=ICsFErJUEX+AQu/hApQvB9fCR9BmfdnsQdVVTCvSULDjkKxCbq25cNMTngLDYoUFidi2QajCkJsF3h/++OQZjd3XtSsoPYvlG2lJNy4cCBzKMYX9D8C/nvGG4MSM7UpLCerdpEw8TN1xWVv0Ae0+xWt8RSD5MbOBhDwqOyHzMu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823108; c=relaxed/simple;
	bh=6lPH23Rh+QszyIdt3YFQp0lH/bK/PD+xajYaYu9MYCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POjh+SXq5r4/R/zgNJfcsx9ppQUQ7gTdNSd6Rb6x3GEFqGQd7fVyuoM1Wtxc7MYGWUYTtVcXzFBViHkhXy5TFKuCEAMJ6Cl9oKQnsoMAb5/4hprMy5DTpgUKTs8CpatULY6QfBbykqy9UQ2/fmlpNbWGxKAmT7wr9XNoUfM7Xbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWGwe0BA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18D4C4CEDD;
	Tue, 10 Dec 2024 09:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733823108;
	bh=6lPH23Rh+QszyIdt3YFQp0lH/bK/PD+xajYaYu9MYCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nWGwe0BAHv1eH5g70SGWxODPXVgEmgIUobhzqWDGqLscy1aaJymKUxa3sZQGjqqFx
	 s/UUmMYinsB45qygSBX1F0BAh1FWtnroJHU1uZOJHGtid/l+/GWdCrT8SWUtQfRqoJ
	 P1if5AephTjRy/Cbe15pPNVLQeLclEbqLn5M1YVN5Yk8ELlE5vtt73oI7Np9F3F7y/
	 DLLCJPMOUp2QAmSKyT1k5VJ3+svFYY7ih17kSEQ8zRxTalMvThC1lFIwpKidjlR1a1
	 Z7KLuU+RoIY6cfOGod+JX4u3pVfuTvOsH/FMTqbCm+OtJ+pd70dbfDHlIJznAyOXEm
	 aIQCqBZt0nOvA==
Date: Tue, 10 Dec 2024 10:31:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Cc: Kever Yang <kever.yang@rock-chips.com>, 
	linux-rockchip@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko.stuebner@cherry.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: Update rockchip company
 name
Message-ID: <btlvyji7avk7n2oghn2m54ipxtreml4pe6mrysrju7brhrghmt@o3ezyi23u535>
References: <20241205082258.857018-1-kever.yang@rock-chips.com>
 <kwx76ihsftsgw3u53l33z4kodihyfcvpqpl2a2nk7aedgnr6e6@2324w7s7zmio>
 <10907239.zapYfy813O@diego>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <10907239.zapYfy813O@diego>

On Mon, Dec 09, 2024 at 11:03:08AM +0100, Heiko St=C3=BCbner wrote:
> Am Montag, 9. Dezember 2024, 10:42:50 CET schrieb Krzysztof Kozlowski:
> > On Thu, Dec 05, 2024 at 04:22:58PM +0800, Kever Yang wrote:
> > > Rockchip company name has update to below name since 2021:
> > > Rockchip Electronics Co., Ltd.
> >=20
> > Some reference would be useful. Wikipedia says:
> > Fuzhou Rockchip Electronics Co., Ltd.
>=20
> I did go digging a bit:
>=20
> their main english page [0] at the very bottom (in "very readable"
> light gray on dark-grey ;-) ) says:
>   "Rockchip Electronics Co., Ltd. All rights reserved"
>=20
> Similarly their about-page [1] says:
>   "Rockchip Electronics Co., Ltd. ("Rockchip", stock code: 603893)
>    established in 2001 ..."
>=20
>=20
> Heiko
>=20
> [0] https://www.rock-chips.com/a/en/index.html
> [1] https://www.rock-chips.com/a/en/About_Rockchip/About_Rockchip/index.h=
tml


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


