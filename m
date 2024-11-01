Return-Path: <linux-kernel+bounces-391834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68AF79B8C2E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 08:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51D251C211B6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE210154BFF;
	Fri,  1 Nov 2024 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFZLL8Gp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6BE153BF8;
	Fri,  1 Nov 2024 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730447026; cv=none; b=MpkNbEvsxPMj7zDZnutM3eMwId4l+znQD0ntrtlGy+UAM2Gkvla3EsmdpbF55xEPu76/22bSHfb2JNMU0AxQAkGjFVNAMbNHlMtclnJzY1MuFaZO69acUMOAtsBSVkq0R9KXJR//NQuBYlgDrvEW0cqZ5Gwb8V/A9+Dk+DzUH1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730447026; c=relaxed/simple;
	bh=4x31p+DZMYjlyqb/3qb3jrPA9zgWoWJenR9Dv9pBFj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUCvhydOjhBCkAoJ8MrAy6gzTZeTdfHmNfDJ/pP4HxYA303jlH3ZaGlkGYyJZGMJT2L/u+zF7HMgclUWVkeqcs17fE6vHGIKC31fWAMfr5WuHfYlQ0FQWF7K2Xy6kFxExOG8N7GWYz1JrSHd/zlw/btcUC+eJ7NJ3/dzW1BBnoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFZLL8Gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BC5C4CECD;
	Fri,  1 Nov 2024 07:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730447025;
	bh=4x31p+DZMYjlyqb/3qb3jrPA9zgWoWJenR9Dv9pBFj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFZLL8GpCtR9rd3lymn9fDwBjvtFwGZWKmFxf8IT9YoygQhYuwPkD07qplsvLjj4n
	 PKaxbdNMbgLEKaQQexsS+hcrhawlUygCSCqA16aDo21KKbRFrZA3UB1JfEV3A7/coi
	 YkkwmkSsQBpK1/3zx26ZxBIfxwUEhRtp102LZzFBNKjoJZ/X096FKl+XRLXOxCjhD9
	 gO0vwHSxscv/TQpcbQ8kJuarjp71xWUd/a1Jxxz94AT449HDMSILXaD072Dfvp1+E1
	 RUdMf6Ibz037l3ffR5efDVtcdVoS1eKIIS7kWaBXNH7HXoeulZ5ubXifyjgXXAcYLG
	 iTgWrWr+3v1MA==
Date: Fri, 1 Nov 2024 08:43:42 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: sound: sprd,sc9860-mcdt: convert to YAML
Message-ID: <xdkv5suqkuln64y3rhzydm47otn5tkpfj2ekowaadol25gdfc4@2dqxewpa5g6y>
References: <9fc646b70a73e7a6c513771d69b0edcd140f09d7.1730310275.git.stano.jakubek@gmail.com>
 <140ee384c1c351ffa3abefa8dd3246d1625dda8d.1730310275.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <140ee384c1c351ffa3abefa8dd3246d1625dda8d.1730310275.git.stano.jakubek@gmail.com>

On Wed, Oct 30, 2024 at 06:49:22PM +0100, Stanislav Jakubek wrote:
> Convert the Spreadtrum Multi-Channel Data Transfer controller bindings
> to DT schema. Adjust filename to match compatible.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


