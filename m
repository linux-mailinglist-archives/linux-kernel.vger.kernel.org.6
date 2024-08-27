Return-Path: <linux-kernel+bounces-303673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C586961377
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 18:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E80284D28
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE991C9DF7;
	Tue, 27 Aug 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBjnBdjn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122BB1C6F4F;
	Tue, 27 Aug 2024 16:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774413; cv=none; b=g+n8uKcb/I8Ci8LnFUA0ULdhfEOE/I7ydAHqOEMN2252sIWF9yXgQs/Q3dVweLUTJcJRQM3q0eTW6luym/7yg/2qpkYHG6kTC988dtQ2nooYZts06zhVnLqEhhZmFnkJ0PkCYGbGMerywWPJeCShBkMMXTqJD+5oXg4ZYZO57RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774413; c=relaxed/simple;
	bh=glt23gL14OT29ySgLa2OLHvgpFuLQ4dVuwOcWfQCHhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMHziV2/MeTsgiDK5Bv18BGsvJiUSWITFi7ZOeNnJjdbk2s8AV5HKCozfE1pi1fCD76Iba8p67lPbMAGxECBertbgQFWRKuGMVX4nTjSDp/H3rJVszhbuyMN8wS8df6g7NEHEAKgyFUIEvzuBiZ/uk9P2iadL4chxgLWiQBwE9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBjnBdjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FFFC4FE0A;
	Tue, 27 Aug 2024 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724774412;
	bh=glt23gL14OT29ySgLa2OLHvgpFuLQ4dVuwOcWfQCHhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBjnBdjn1AI/zAlDKPGgTVd+arH3lcdjpMzuPQjwabOLKdcIjEdWwTYDjZUeXCQ1H
	 3zHCw/ZhXiZIzgxXqckqYfAfqafahvLlH4yuuopHc/hk9BtE+AZ4e+Djz7W9P4RQww
	 7nFYf/Ikbpq/PgSp+Tz9lmz9tCvkqIQ6Kp795AZMOubilOuctNdMruyg8D5S44a8mk
	 QBGqJuSBpr06F/2AtwFoniaBdUwHu/lVR+qhnRaSpuvubLHshFlvOkmgw5ngUkFGw7
	 BzPecD7pqJIKFz9lhM6VrBd4HPPCzy+3YmJwyi/hylLaVC+6vrjyMXH+6uS/0fv5kk
	 u1fZnwkjtm/Dw==
Date: Tue, 27 Aug 2024 11:00:10 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/1] dt-bindings: hwmon/regulator: Convert ltc2978.txt
 to yaml
Message-ID: <20240827160010.GA3965737-robh@kernel.org>
References: <20240826163626.961586-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826163626.961586-1-Frank.Li@nxp.com>

On Mon, Aug 26, 2024 at 12:36:25PM -0400, Frank Li wrote:
> Convert binding doc ltc2978.txt to yaml format.
> Additional change:
> - add i2c node.
> - basic it is regulator according to example, move it under regulator.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
> 	failed to match any schema with compatible: ['lltc,ltc3882']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v2 to v3
> - put my name into maintainers.
> change from v1 to v2
> - maintainer change to Mark Brown <broonie@kernel.org> (regulator maintainer)
> - update title to (from ltc2978 data sheet).
> octal, digital power-supply monitor, supervisor, sequencer, and margin controller.
> ---
>  .../devicetree/bindings/hwmon/ltc2978.txt     | 62 ------------
>  .../bindings/regulator/lltc,ltc2972.yaml      | 94 +++++++++++++++++++
>  2 files changed, 94 insertions(+), 62 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/lltc,ltc2972.yaml

Based on the discussion, I think it is easier if we just leave this 
under hwmon.

Rob

