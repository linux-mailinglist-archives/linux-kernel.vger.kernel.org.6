Return-Path: <linux-kernel+bounces-447472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67119F32FE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B778E18823D6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A831C205ADE;
	Mon, 16 Dec 2024 14:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTFUOHlW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C5020629F;
	Mon, 16 Dec 2024 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734358729; cv=none; b=HFDediiUxBQlW6tAHNk59Po3w8Osz/5j1bxClAiezSazs5yukOB266g9BMuS11GfEbNuuPOE3HyJ1zxF0uFf5NJ6DkdQ9xIFQWkDAUUJRIGMk5OOSy+uSlmP4DJEATDABfvLR4G5NS/OkjeTh9v/AapYMylJD45vDg13iBMZiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734358729; c=relaxed/simple;
	bh=r6E23SJ4NnZ0p4J6lfmWJy3886HYCKhaM5ebito097Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwIRlhNcx1YGfHrH2xkkFqG6gGTK718TFxMX9vAedUEVEr0vaNc5qkB2/3YyUKniZWdIcOtzWAj6scwsFGOYZuOAeJjxrSg+MbKSuNnGX9A33iSzElv6mTvySxFnJZcXpgt0GO/q2jbIr3B4ZmwXqqga90yVDJjKx0aKseYbXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTFUOHlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5631CC4CED7;
	Mon, 16 Dec 2024 14:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734358728;
	bh=r6E23SJ4NnZ0p4J6lfmWJy3886HYCKhaM5ebito097Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTFUOHlWU9dh0laVfqTmC8ijE2UkEjvZVlVxgqpslvt8Zz3fLqFDZ2K0t2mYgylcH
	 chBzA4IVhAjg1gnwmv2Wz036/a5CtySTl2dqMFYk4gldmv3D2UmzI8z67o8H0z+CNB
	 xALkysus5ZvsIi1IkM2Dx40oyYI2X4j5wEcCBZYjV0jhlgiXeif+TfrrQ/ivSgSLmY
	 zN9KaAZz+6VNQ7r1z+XSU1pfd0Y8O+DEPNo2XdxA1d6Sm5791Azc5GEM2T7MxemRmW
	 fbEjXc17ZFqF+r2mcFv30/jdJi+cfqCjPQQ9iEd0k64aGsrQnDZLgOuCZPh85JoQQP
	 Hc8XOm6nl4Sfg==
Date: Mon, 16 Dec 2024 08:18:46 -0600
From: Rob Herring <robh@kernel.org>
To: Peter Griffin <peter.griffin@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	tudor.ambarus@linaro.org, andre.draszik@linaro.org,
	willmcvicker@google.com, kernel-team@android.com
Subject: Re: [PATCH 2/4] dt-bindings: mfd: syscon: allow two reg regions for
 gs101-pmu
Message-ID: <20241216141846.GA71151-robh@kernel.org>
References: <20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v1-0-c72978f63713@linaro.org>
 <20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v1-2-c72978f63713@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-contrib-pg-cpu-hotplug-suspend2ram-fixes-v1-v1-2-c72978f63713@linaro.org>

On Fri, Dec 13, 2024 at 04:44:39PM +0000, Peter Griffin wrote:
> To avoid dtschema warnings allow google,gs101-pmu to have
> two reg regions.

It's not a "simple" syscon if you have 2 regions, so put it in its own 
schema doc.

> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
> I don't really like this patch, but also didn't want to submit the series
> with a dtschema warning ;-)
> 
> Possibly a better solution is when Robs patch
> `mfd: syscon: Allow syscon nodes without a "syscon" compatible` [1]
> 
> gets updated with a v2, we could remove syscon compatible from
> gs101.dtsi (an ABI issue). If I understood his patch correctly,
> it would mean this yaml update would then no longer be required.

Whether you can tolerate an ABI issue is up to you.

Rob

