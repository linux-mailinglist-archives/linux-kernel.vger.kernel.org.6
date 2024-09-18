Return-Path: <linux-kernel+bounces-332799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 336CF97BEF5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57706283706
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9012E1C9851;
	Wed, 18 Sep 2024 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnUuMzlV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD68493;
	Wed, 18 Sep 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726675577; cv=none; b=QdYKsMZt0jSUYQEIRzbf18qD5svXWCFnN4pD5XwRgSDOPDeBJB57w8Trh/SpHZ00ESBvMFrXfNAvUfWoK+8/wjHkLdm1EhGQDeemnsmHRIsqd91LKjitL+uZEAB7PMtDvhx/Cg4yQU2JWRrzoribctBoYVxPgRtQyUO218l3tEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726675577; c=relaxed/simple;
	bh=k/cNz1MX33DavMoavpeGHsyNZuYMlTT3z7+1FXoHZ8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1sv40yTwaRpVjM1GqsaVZJje/nPuE7eYwOBqdJtgBWmGkK51maBtMjG9rPma3y9QvjQMsC28MNu8DrXXGXkOfB3u/04qrHN/4EncNYViQlLt6Dn/bfyNhFboeoEwZa4br1Fye+HGFqkJAOs5bmJom0aVqz2U9ZozZzLgTMPl7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnUuMzlV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 542CDC4CEC3;
	Wed, 18 Sep 2024 16:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726675576;
	bh=k/cNz1MX33DavMoavpeGHsyNZuYMlTT3z7+1FXoHZ8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fnUuMzlVKSIK5Pf9pMjUoKc6GzYcAKW4FCOZZ9H8Zz+JR8phNR9iUq3xa930sSBSv
	 wQMuI0q1nu3E+kRI4CEmRpOg34HLXIMMB0r7f5222TtcqmaYY9uYi3/xH6+0g/hE1j
	 a1AwN3CXT2NSv6g7/ySkqOhAfXyXdML4uhTDRrYV/yRLQEuNLXvBlr71ukebOoh8Sk
	 vHn5/NqNHHOX3WdOA2YkZotkwQ49YLczautW1caQw67uRZPOYjulZHhC4RTvm0HE96
	 wH6ZQLqQyH74yR59y1bGirlZ/U/edMEHehweinp2FZAI+9KkUrMH1paGmkWhbf6hmv
	 yF0yRJEg5qzGQ==
Date: Wed, 18 Sep 2024 11:06:15 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Chuan Liu <chuan.liu@amlogic.com>,
	linux-amlogic@lists.infradead.org,
	Michael Turquette <mturquette@baylibre.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: clock: add Amlogic A5 PLL clock
 controller
Message-ID: <172667557462.1691676.860545750561739288.robh@kernel.org>
References: <20240914-a5-clk-v1-0-5ee2c4f1b08c@amlogic.com>
 <20240914-a5-clk-v1-1-5ee2c4f1b08c@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240914-a5-clk-v1-1-5ee2c4f1b08c@amlogic.com>


On Sat, 14 Sep 2024 13:25:23 +0800, Xianwei Zhao wrote:
> From: Chuan Liu <chuan.liu@amlogic.com>
> 
> Add the PLL clock controller dt-bindings for Amlogic A5 SoC family.
> 
> Signed-off-by: Chuan Liu <chuan.liu@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../bindings/clock/amlogic,a5-pll-clkc.yaml        | 62 ++++++++++++++++++++++
>  include/dt-bindings/clock/amlogic,a5-pll-clkc.h    | 24 +++++++++
>  2 files changed, 86 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


