Return-Path: <linux-kernel+bounces-332906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D9497C092
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A3C283137
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A3D1CA69E;
	Wed, 18 Sep 2024 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcwQzjPC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D312B17C;
	Wed, 18 Sep 2024 19:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726688215; cv=none; b=DYUN3OlgKj5OR2I+GP7XYztflaHPkb5FFnq7Ka/I/8yvKyq3oWsTMb26Qph6mKWVczqP4cfzCtXECzHfxL+lZMoq9frvE620FN+Q9K38BHEhzG8cuoGjFmAOBi7hGY58ff6OY/Ro3xA2tmAr8QQugVzByF0yIe5pvg5/PogBVnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726688215; c=relaxed/simple;
	bh=5bZ1Yoj6niUYHDQb1J8phNqCotVR8fsQiObDLwdQHjc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=X+zRdsYZhnRq0VUmLxJE9CEa7e6Ap04D8m6WFBpNDOh2T5WTrWtEJJCS0LvBaINnhXbu9D8jO8hc+ON9TrNao3q/MdB45J2Nmx0Agh55jVbl4zYZFJqgp+5fV2vk2zrbCgUnk+rS/TsptyBmdyetIX+fn2hdWwnXWUuO71pEkiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcwQzjPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C097C4CEC2;
	Wed, 18 Sep 2024 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726688214;
	bh=5bZ1Yoj6niUYHDQb1J8phNqCotVR8fsQiObDLwdQHjc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=EcwQzjPC9CaubYEDs7x9Z7+tBDpe3i+Nrm0uxqCk3SuHrtamBvgtk1kEfJLyProkR
	 47AYnWV6xNTd6jJGKmK+RKX+p80hQUOUHeWCLcW/I33Y5PszqlEfI3wf/sz3pjjmtz
	 Cd9HKm/12ACZwi0IExzyWb1GloGVy5QbzgON5nyw4OuSxCKmzAyveWU58LkOJJ5Cy+
	 iYEjy+mha63NWJGJv6LKwNptiuf+HCB6UWXkz9FgiUeeumbDoPeQF5AnXHfvNKxzbG
	 cJkgfW7LpCPCuckLDSeFO9FWUJbHt0qBVXbGs+jv2atpYBeR2NE1bHoQ/Q7/Y/ZD5C
	 n7v0wQArrrRPQ==
Date: Wed, 18 Sep 2024 14:36:53 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Iuliana Prodan <iuliana.prodan@nxp.com>, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Shawn Guo <shawnguo@kernel.org>, 
 devicetree@vger.kernel.org
In-Reply-To: <20240918182117.86221-2-laurentiumihalcea111@gmail.com>
References: <20240918182117.86221-1-laurentiumihalcea111@gmail.com>
 <20240918182117.86221-2-laurentiumihalcea111@gmail.com>
Message-Id: <172668821340.2009095.10209806970812964896.robh@kernel.org>
Subject: Re: [PATCH 1/5] dt-bindings: dsp: fix power domain count


On Wed, 18 Sep 2024 14:21:13 -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Per the current binding, QM/QXP DSPs are supposed
> to have 4 power domains, while the rest just 1.
> For QM/QXP, the 4 power domains are: DSP, DSP_RAM,
> MU13A, MU13B.
> 
> First off, drop MU13A from the count. This is attached
> to the platform device of lsio_mu13. This decreases the
> count to 3.
> 
> Secondly, drop DSP and DSP_RAM from the count for QXP.
> These are attached to the platform devices of the lpcgs
> (used as clock providers for the DSP).
> 
> With this in mind, the number of required power domains for
> QXP is 1 (MU13B), while for QM it's 3 (MU13B, DSP, DSP_RAM).
> 
> Additionally, two extra power domains may be required in the
> case of QM/QXP DSPs. These are IRQSTR_DSP and MU2A. For the nodes
> using the "-hifi4" compatibles these PDs are optional, while for
> nodes using the "-dsp" compatibles these are mandatory.
> 
> These changes reflect all of this information.
> 
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 62 +++++++++++++++----
>  1 file changed, 49 insertions(+), 13 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dtb: dsp@596e8000: power-domains: [[4294967295, 0], [4294967295, 1], [4294967295, 2], [4294967295, 3]] is too long
	from schema $id: http://devicetree.org/schemas/dsp/fsl,dsp.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240918182117.86221-2-laurentiumihalcea111@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


