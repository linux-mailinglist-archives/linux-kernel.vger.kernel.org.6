Return-Path: <linux-kernel+bounces-198752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 372138D7CF4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E661A283811
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D96A53E37;
	Mon,  3 Jun 2024 08:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNhCh1HI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AD753365;
	Mon,  3 Jun 2024 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401703; cv=none; b=PS85/7ZfJviTf6rMZ6DLVLwmjYCxtj3BrBO1N2sPwe/RkqUr9phmKLT7O2m2jOzDwYS78OrXWXja1bX2SmqXT47+jOL+62Es/A+ooWKHotPLVzg8lSQTZN+M1cp9829MVyhJE+AVvAURgzL0B/8NyD1xTXw4I6XyFl9mBABpy0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401703; c=relaxed/simple;
	bh=LnYmCqjGpsS/Ly+reckzU1OM2GJ1nThU9j89j8n9yUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNkG+akSdPw16rDV7xVCIUvwjKbsHGg2zmElcQpCC655093wg0ahVhTtAFaLdYZeMgOlEJ1JQZ9Sjux+6OGKdLmynlADvqvFIS2K21/XgnpBgQviu6YLG73Jnb+4hCevt4w1duYx/bZTEBR/TIhH16+iT0T68JDds/j57SIOR40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNhCh1HI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C326C2BD10;
	Mon,  3 Jun 2024 08:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717401703;
	bh=LnYmCqjGpsS/Ly+reckzU1OM2GJ1nThU9j89j8n9yUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qNhCh1HIJkDlzMkCdGk/Hso2O9BKY1U2xeJa7NkuWSf4UdKS9w/O5EDODQX2X4B4F
	 ZpjkQXA48SPeJRS9Twotj9t0T1lEQTkGZXryTrnjuFZTBeqIpKEE/oitLr84JDrJWN
	 7fMpx8CiCs/GlNZuBxNT8EL4qqttNwL+jhQ5/jYkXhiqofxmAzsprMu1lJ2CVrXLJr
	 5gDA2HyPWYXa7jQLZVnoBi4nvWX3+hbXIO3wUoCfZuXCjWUOBDlSk+GxK0TvUYNYNp
	 i5DVIlGef/rZbQhILQqGuUOGR30ShAl//U3LNXCw1Cd+e4pLyO6NiTfy0yVAmYMEDi
	 pdMpIFJQ4Hkgg==
Date: Mon, 3 Jun 2024 08:01:39 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev,
	linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: repair file entry in CHROMEOS EC HARDWARE
 MONITORING
Message-ID: <Zl14Y2tia0s-BEht@google.com>
References: <20240603072352.9396-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603072352.9396-1-lukas.bulwahn@redhat.com>

On Mon, Jun 03, 2024 at 09:23:43AM +0200, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit e8665a172378 ("hwmon: add ChromeOS EC driver") adds a driver, some
> documentation and the new section CHROMEOS EC HARDWARE MONITORING in
> MAINTAINERS. The commit adds Documentation/hwmon/cros_ec_hwmon.rst. The
> file entry in the MAINTAINERS section however accidentally refers to
> chros_ec_hwmon.rst.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Refer to the intended documentation file.

Thanks for your patch.

Received a notification about the error in [1] earlier.  Given that it is a
minor issue, I fixed it directly to the original commit (instead of sending
out an independent patch with Fixes tag).  It should be fixed in the following
linux-next (e.g. next-20240604).

[1]: https://lore.kernel.org/linux-next/20240603132517.7f344f9f@canb.auug.org.au/

