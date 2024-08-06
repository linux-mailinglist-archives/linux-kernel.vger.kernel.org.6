Return-Path: <linux-kernel+bounces-276441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0FF9493B2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA0E282D28
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475561D54E9;
	Tue,  6 Aug 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnWbey7W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB1B1D27BF;
	Tue,  6 Aug 2024 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955796; cv=none; b=YCPKwWmdMrTsjMh2wh6SzDtTb1+cDy8pHHXgYl5HP1BIcj+qJqOrIPPn9LG33IOmhmc+sMyza8N1de5nLHnsL2Ss0aI0OsrLegylahg4MpmbgYenVogdU1cK0wSrl3AjXkVzhrPAlP1OWjCpZwQpdu5djTRBsbCVkjrjR0XpFuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955796; c=relaxed/simple;
	bh=XuHKSNEF5tUvOJPgFsKx+s1jAJDpE7QZHFV4+pWcMUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akYJ1BKoR61FbArM+Od5sTXr9Jxvg3768fSuk3MAap0rZdlqyUc19vE2Q3cSTr3dIltWk+/u1uXjieBHan4JKTKSoqD0sWJaK4H910L176oMPdh03nUExk+QAM1FPZ3tO6QUGnDwkZcyTssFtKWVZdwvj0Su11LbpgTFWwA1Ct4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnWbey7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0251C4AF0D;
	Tue,  6 Aug 2024 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722955796;
	bh=XuHKSNEF5tUvOJPgFsKx+s1jAJDpE7QZHFV4+pWcMUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnWbey7Wt3vrLuWQg07XZBWzEHNPKTvJ6lP3q5FgCXePG+ahfM23ggCUIUlO54Oxd
	 RR5IAJEFIzWKlCZyECGulSNuYh9KAdiYzs21sZig7MqMRNRTgvY3uZt7Fx+SKjY41A
	 URAODS1yppvbf/o5I+fADky9M+mq5BfVvIXpBhSW5O+iP03P2v54EGU8T1xmGr9xB6
	 mnLqHNupM4xaMx1qUWpstlOM9HlGGkQH8kGBw25BDwFKZGbtZ1smAcqHxfcaGGr4do
	 7tiJtvQqnRv8jVLaE9sVT7OLrAGxLk/8l3IF663+VOA7NNy/P3rPZuxEWNxsoE1ze4
	 SWRFqGcK55Jyg==
Date: Tue, 6 Aug 2024 08:49:54 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	fabrice.gasnier@foss.st.com, linux-iio@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v6 6/9] dt-bindings: iio: add vref support to sd modulator
Message-ID: <172295579421.1502183.14918805644407235490.robh@kernel.org>
References: <20240730084640.1307938-1-olivier.moysan@foss.st.com>
 <20240730084640.1307938-7-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730084640.1307938-7-olivier.moysan@foss.st.com>


On Tue, 30 Jul 2024 10:46:36 +0200, Olivier Moysan wrote:
> Allow to specify the reference voltage used by the SD modulator.
> When the SD modulator is defined as an IIO backend, the reference
> voltage can be used to evaluate scaling information of the IIO device.
> The reference voltage is not used otherwise.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../devicetree/bindings/iio/adc/sigma-delta-modulator.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


