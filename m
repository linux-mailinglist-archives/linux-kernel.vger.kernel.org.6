Return-Path: <linux-kernel+bounces-448541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C80419F418F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 555DC188B552
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1381411EB;
	Tue, 17 Dec 2024 04:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVKiv4Rn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89617145B2E;
	Tue, 17 Dec 2024 04:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734408436; cv=none; b=e+Jv35gTgHE8JkumXrx/SmDnrmEtIZ8kcG7w6MFALvwbixoYA3J9UGNV7TVnGRsEnz5eQN0rULgcWfxDpSmXVE7voYUEFK4CSD+hDvyugSamXHefwo1cvtyaDrJvoeapD7NOYzEP5e1bzr7C1XBjpmsEEwTdwAXTsV7m0yTgmCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734408436; c=relaxed/simple;
	bh=bPac97JyG/xSS2KUv9h2hb+Cgu9UbkKYxIyPMQgGts8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=And59VaawMoQQyHvrId+8bcFSaIG+MPeSLYKDxjs6b+0mvkpA5k7yUegotoKGy5gl6Y/r2BvsI54WZ/Jn5rk5XejQJOXorAo3VIBOEYSSeXuIymW7e5DnPZpGuePgA02xJqO55FeEB/DoBU8x9yfCP3kWLjxmmQ5EyWeckizLd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVKiv4Rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0F8C4CED3;
	Tue, 17 Dec 2024 04:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734408436;
	bh=bPac97JyG/xSS2KUv9h2hb+Cgu9UbkKYxIyPMQgGts8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVKiv4Rn6sRbZyhm5gIwT1xmgSmOxq9fGRA3PDpGeBs4mdA0XFt/+SEzr/yIEHsBU
	 DwTuisagkSeiBlXMok8ZNWcIi2IJjWvrXRjmhC8/xGIw3kk5CZtZVycP9xlekPGaQD
	 9ZpcqSNgfsbHdQ7fpDLrUDMimlV99azB2Xgod1yLTc60D6e9UUkAFoiKEP5AwoZBjD
	 ENv2Eu6bfmnDmVvq8t3gFl93Yt1IaV8wisSJQCRmjP1IpXwu2BLfZfS2sES+n0uMOP
	 R6rwbct7b0L5e7iIsbjNL9XODxARpEiWyncwS8d4/pTAW1wHY+vYwSgiplxCo03Gu2
	 JsbsxooCPKE6w==
Date: Tue, 17 Dec 2024 04:07:13 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: cros_ec_vbc: Constify 'struct
 bin_attribute'
Message-ID: <Z2D48S9Z9crRa7LN@google.com>
References: <20241215-sysfs-const-bin_attr-chrome-v1-1-92249c4bc295@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241215-sysfs-const-bin_attr-chrome-v1-1-92249c4bc295@weissschuh.net>

On Sun, Dec 15, 2024 at 02:29:15PM +0100, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: cros_ec_vbc: Constify 'struct bin_attribute'
      commit: a0355d4d55f31c34d957ab1d94a5776ce235f786

Thanks!

