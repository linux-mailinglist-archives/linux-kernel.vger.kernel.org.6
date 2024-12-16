Return-Path: <linux-kernel+bounces-447068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FD99F2CE8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936BA167051
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C7920102A;
	Mon, 16 Dec 2024 09:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EA9QBf4d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461DA1FF60C;
	Mon, 16 Dec 2024 09:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734341108; cv=none; b=JGJ3KuSkM136uFFyqdO5mkEwjMGBiL6arHeH54CdGgXbpD6ZBmZXlZebFBr1FVOVP5bBqnbDDi6tF5DEGrXF9FQqZKwNf2fd6V5+X1Lcl5uoZrm4Nb4qDVsn7kHcvsL5Tj3e6dKOCrpF84WV6fWlog0AaEY+OXz+CbZ+mipA4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734341108; c=relaxed/simple;
	bh=AXyQC9Z7cFWiwHOgANPVRn+y+9CqJVcfYwaFKvv/1Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StK04faDl0edVYEElrAYC8jqeVk4BUX+pXBEZj5CtqiwpQ5ORXZna2Z5XInCYForHZXdilS3c3Oq+FWJp0bTlev8zExPqrXz39538PQCq4KXOt63yyDwzm5LUL49foLOrwpbAIv4ABUiv3N/8DDzm69hB19/txRUTlHKCzeVT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EA9QBf4d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274D2C4CED0;
	Mon, 16 Dec 2024 09:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734341107;
	bh=AXyQC9Z7cFWiwHOgANPVRn+y+9CqJVcfYwaFKvv/1Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EA9QBf4dnF49dEEZ74xojG7UpES+Ig05mw53h01FQ/5cZMMJSlISA4pf1+j3qhslf
	 0SgaYmWUhDctodLKn4xtsTZOvArZdvfB7x3BZNyKNnzkrBCiqMHfRs3L7lqrI4liR9
	 i7Wuma4XqcC3hHdPlWx1LH1Z2U02eU21t6GywQTgGeZ8Xq6s9ipKOPB7SrVLF5nj1x
	 cpOkTpi6kg8bDQTvubWCW53Z81MTvarPYPK6dO2ASKlK8wI9BT/FJAbFrLZjEjs9Lu
	 9+FgSgWw1U2jIwsS+B0iqIMnJ42k8BmzbdBjFES3g+naM7IuYG8HO5N4dApQCspIuA
	 maTR007k6TuSQ==
Date: Mon, 16 Dec 2024 10:25:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joy Zou <joy.zou@nxp.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: pca9450: Add nxp,pf9453
 compatible string
Message-ID: <qnm7z6ltflzpi7cxggalytc3xd7pznt6t4oga5to5adngkxz7d@kpbjcj5geahl>
References: <20241213-pf9453-v3-0-5587c1693155@nxp.com>
 <20241213-pf9453-v3-1-5587c1693155@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241213-pf9453-v3-1-5587c1693155@nxp.com>

On Fri, Dec 13, 2024 at 03:46:08PM -0500, Frank Li wrote:
> Add the compatible string "nxp,pf9453" for the PF9453 regulator. The PF9453
> is similar to the PCA9460 but supports only LDO1, LDO2, LDO_SVNS, and
> BUCK[1-4].
> 
> Restrict LDO and BUCK numbers for nxp,pf9453 and keep the same restriction
> for other compatible strings.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v2 to v3
> - LDO_SNVS to LDO-SNVS
> ---
>  .../bindings/regulator/nxp,pca9450-regulator.yaml  | 24 +++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


