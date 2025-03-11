Return-Path: <linux-kernel+bounces-555639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378CCA5BAA7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 09:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781641684E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801AC1E7C11;
	Tue, 11 Mar 2025 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZmENIUF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BAA1EB5FD;
	Tue, 11 Mar 2025 08:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681021; cv=none; b=U/32KfnSVgvnHaMv6x+Mq0/kx7gkMwZxnRgSyRXeZgwf+pUe2xNMkLILvPrPtPqlF3pyvVIP0BTo6nPxkYTNTprVbAWIa8ae1ZjKnvN8FH1YpiXMznXt8RYDXswmSmuhXlkPA797OcLnofmX5i7wg+D+Dznh3mRDdqkNnThSkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681021; c=relaxed/simple;
	bh=qzksFsHwUZAZdl059Q9dYveJ5pvso9jFFjPVpDgEbd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTJBejMr9lE9W1IPabQ/bTLi3sclUALv9e22cCuwd+RqcDSxMFRBwCMY2k1J5OfqdWLAM+4ZIDxC9BEPHJK5EMAwkzzpeHU1+M8rZ7ahD3IRFXIBYrhBMHpa1s62Ohiz5C+4pGwJ0lR8nhVD0usXvC8bylIiZhXz5s7ah9TmvtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZmENIUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70269C4CEE9;
	Tue, 11 Mar 2025 08:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741681021;
	bh=qzksFsHwUZAZdl059Q9dYveJ5pvso9jFFjPVpDgEbd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NZmENIUFu7jOuBLc8tK9jQIJs7hzrt5xOV43/NGKih9hZnUxXyagM4pLvsos+raNM
	 fKt6PigNDT53PJSxWG0ljsBzAzp+Bx61h9G1ihZXaI6xeDnS/nHqNOvTTVY718b187
	 I4sDfB/hJgaDg1apyDlhBld5DrWiAQYC1jU2x9jlKnvLmhKM6k8YCjbz+miSsZzUbj
	 9tqNOteSSj3eUmLr2Uzjlyt8qOy+f2RBzbnrpGLt/AjcUnUJBgaoKKunCW78YXC9/C
	 mT7Hk6mSpCHwSA+yNyeSlEnOsdnkBExitrlhXsGvWabUcivkHF2fX8n0gc11a5FPG0
	 Pqbshzo1yKTcw==
Date: Tue, 11 Mar 2025 09:16:57 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v6 2/4] dt-bindings: clock: axg-audio: document A1 SoC
 audio clock controller driver
Message-ID: <20250311-famous-adamant-teal-20b1cb@krzk-bin>
References: <20250309180940.1322531-1-jan.dakinevich@salutedevices.com>
 <20250309180940.1322531-3-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309180940.1322531-3-jan.dakinevich@salutedevices.com>

On Sun, Mar 09, 2025 at 09:09:38PM +0300, Jan Dakinevich wrote:
> Add device tree bindings for A1 SoC audio clock and reset controllers.

You sent multiple copies of similar series to which you got responses. I
don't know anymore which should be ignored, which got my response, so
just in case I will skip this one. Please implement received feedback
(here or in some other series).

Best regards,
Krzysztof


