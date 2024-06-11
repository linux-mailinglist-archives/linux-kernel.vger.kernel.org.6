Return-Path: <linux-kernel+bounces-210551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CACD904570
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62391F232C3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A59E14F135;
	Tue, 11 Jun 2024 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhYvqFGP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D997BB17;
	Tue, 11 Jun 2024 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718136050; cv=none; b=lLIDnVE70J6hYCL1iWAiyY2oG0qxqOAu3cZ6kYtLG9YYVZ2g1AOQP3a6AMUHWKrrR9K6c/NIgNUt2B1rDrv5yJY2DLTnNkaAxO0n397gM2LwFwjSsskKNfHasQl8g3FwtFli1zqX2d9GfFOOqYPve4ehtBdCv78/iGEae5MXd88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718136050; c=relaxed/simple;
	bh=ystrmlfvgaNRhsglip1S64A313v7s3sbQAPkX47JHms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqquCTyotkpFDdKTi5DoNCdYwY4f+puSzqaMJ9I/lBjoYwaC/GH0W9Lh4dQ2r7q4qVs6CvVoa6aewKSEfO5FjuQcmkwT3GG6cF7nc4mBwWNqbcA2SnDcodYRrwHe2b5gZFcMfXAJGzdvPpv4oZyIhhH+ECflbdG2Cuuv04eTqhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhYvqFGP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041FBC2BD10;
	Tue, 11 Jun 2024 20:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718136050;
	bh=ystrmlfvgaNRhsglip1S64A313v7s3sbQAPkX47JHms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZhYvqFGP/Ns5Gntqx9h5qkrB7hDdPxsXqH3KMpIau84a19ePZ7AybUNC8G4sp/eeY
	 y068Z2FBfKsA2dTfWOa4/wOxBOoob5I9QtNDqcixUuDVS0hL3jxtE4ydWs7AwLXHRE
	 kQQsjjyzrZuJQbh+WJ+Mt+XFXmVgDpVKWyu874p4Ma1MUton4qyd+8QY8fOSeTDEux
	 htn8ETigQPQpN6/0IaCn0AEih5m2c5IVR9KfaTwZCFpN55FXyx9odckXK9DwXGnAXu
	 RLMB6OBf5FA1uaMwWPS+9B6bwUu0ML72vUH8cKfOgc/Nn6XQ/ZrEToDcjxNyZBRyes
	 RadIOkyezld1w==
Date: Tue, 11 Jun 2024 14:00:48 -0600
From: Rob Herring <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: wlf,wm8782: Convert to dtschema
Message-ID: <20240611200048.GA2966276-robh@kernel.org>
References: <20240611124405.63427-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611124405.63427-1-animeshagarwal28@gmail.com>

On Tue, Jun 11, 2024 at 06:14:00PM +0530, Animesh Agarwal wrote:
> Convert the WM8782 audio codec bindings to DT schema.

Missing "ASoC" on the subject. Mark may not see it.

> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../devicetree/bindings/sound/wlf,wm8782.yaml | 47 +++++++++++++++++++
>  .../devicetree/bindings/sound/wm8782.txt      | 24 ----------
>  2 files changed, 47 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8782.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8782.txt

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


This is yet another binding with no in tree DTS user. That's fine, but 
not what I would prioritize converting. There are several ways I would 
prioritize what to work on.

- There's a list maintained in CI of number of occurrences of
undocumented (by schema) compatibles[1]. Start at the top (most 
occurrences).
- Pick a platform (or family of platform) and get the warnings down to
0 or close. There's a grouping of warnings and undocumented
compatibles by platform family at the same link. Pick something that's 
widely used like RPi or RK3399.
- Prioritize newer platforms over older (arm64 rather than
arm32(though there's still new arm32 stuff)).
- Fix warnings treewide from common schemas (i.e. from dtschema).
That's not conversions, but related.

Happy to discuss further what you plan to do. All the DT maintainers are 
on IRC (#devicetree on Libera).

Rob

[1] https://gitlab.com/robherring/linux-dt/-/jobs/6918723853

