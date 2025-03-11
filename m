Return-Path: <linux-kernel+bounces-556845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA13A5CF69
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1E2E3B0995
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2D52641F5;
	Tue, 11 Mar 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkU6GE2Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96296261376;
	Tue, 11 Mar 2025 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721385; cv=none; b=bFtLyoA4ZDaZaI3lRrpTLjEjcCkwEhuI8FBhgzRUlGzLc62a5s2ZDzOm76EdN9FPu1t9PJt69HzC7QI0uH7JfKTNiktk4qnRp6k2S+ZtupJC5SbVDB/Z56nbnfm9QNfZiO76UuTI/Umiu6J+b9WD+97yH+fitWVV+V9Q0dbRvR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721385; c=relaxed/simple;
	bh=zTUZGlfaZpw/Esi/Rx26qQ9HkUg2MBXXI98BiYNbEkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YkKFsIDuNNbBG94D+kO+XfjN054Pyb07sfpEvTvKrjV3oB98/M0eA404/D2vQHPCq/Ss2Om29oBuVU5Gr3rZ3BdfMVxYPrfB2rz4p0XMq+Q16fbceO49/yp7goLtMGMFV0c9brEAGrNzkhCguQGOSYOb4G/t5pU4Z+Yng5kwk2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkU6GE2Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F5BC4CEE9;
	Tue, 11 Mar 2025 19:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741721385;
	bh=zTUZGlfaZpw/Esi/Rx26qQ9HkUg2MBXXI98BiYNbEkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OkU6GE2ZoqCga4zPItg0MI/rxit2xUJe8qwZl6umPLewMufleSQJGedR3Zvsm5DC1
	 +rNO/0FQjmKvajmYeNlCmbEpGGfuO61bdGdmVLIFNQ1Hb9swc341BTAgKWQUYpItQN
	 xbVw47aMuuLuq3CAfG2m512Tm4+fCsmQ3ZhtcFShHjdpujsFFuzDJGyavOChTzI1lt
	 h2rWxY7opyLSOGeXjq8nP1DZGY0HDT9Pv7yQip9rK7OraJ79LQSZXGk0HzrWWduMkT
	 RH8Ea6xrJscRlNd4rwG0thXQBoSVW5i8txpSYm1ikphPUtbmrFlP+zsnhMIByUNkf2
	 SrW/RmFbsAwHw==
Date: Tue, 11 Mar 2025 14:29:43 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-sound@vger.kernel.org, linux-amlogic@lists.infradead.org,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/6] ASoC: dt-bindings: meson: axg-pdm: claim support
 of A1 SoC family
Message-ID: <174172138330.4179604.2763607780913254611.robh@kernel.org>
References: <20250309182127.1322890-1-jan.dakinevich@salutedevices.com>
 <20250309182127.1322890-4-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309182127.1322890-4-jan.dakinevich@salutedevices.com>


On Sun, 09 Mar 2025 21:21:24 +0300, Jan Dakinevich wrote:
> Add "amlogic,a1-pdm" compatible string alias to "amlogic,axg-pdm".
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


