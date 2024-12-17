Return-Path: <linux-kernel+bounces-448540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBCC9F418D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C781F16D368
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AA2146590;
	Tue, 17 Dec 2024 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLqR7oBZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C652982488;
	Tue, 17 Dec 2024 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734408371; cv=none; b=UACry+i9RiU2yPXbOjjvin1RL5RiPpvFQy1KD/8hhQnPal07NCND70h3tDNtYrbf4c6Awm0oyYN3k4LdEOSX/t8tv8NSqSHdainF/DxsUl9Vso3iyl6fIQ+f3DuHNV0SN51vr+Vq01p1TCozCH/3KghYXbTefeqKyAsANlG9DPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734408371; c=relaxed/simple;
	bh=P8b15TtOwYLeNO9xvc9T29ZsQYXoj5syQXtEmdY3bGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8FqyGOeB2W5Y66QWZfr1Rl/n7zCEBQJ/2bP65PMHlZg8HhBnkExf0JGsUOLAEy6nHRB4MV0stfzUuDCXhPQcZhvhYD1wca4RYk2kVC1vV9QMWhXPMXDxxv14AoEad6H/z+4k4s5hQ3/o+tI9W7fjw42+kbVLBN2p2vxOZOrL/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLqR7oBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5DCC4CED3;
	Tue, 17 Dec 2024 04:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734408371;
	bh=P8b15TtOwYLeNO9xvc9T29ZsQYXoj5syQXtEmdY3bGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fLqR7oBZJ7nqAEo0KL2T5uzNbh4pKX20kMLgZDPqe4uAo6nHRrJ1tLtm/eENHoeY8
	 oTDFHzsvGH4HyjvQQCPJyytFvh1A5nFhxjD86Mm1E04Btk97fr3B3sMwujg/TlwWow
	 lUulSycR6o2Ogqs8/SnhLlcm2BYskJ8eNnov6ecOrTfq4K++Bv5RUGrm3sf2xGrmSW
	 jZgJVh/ZiWOGhKzq9+u70RjY561PxmQSvNiZs5z62ftK/XGpdXHbk0PaBDfig5Bwfp
	 3IuGTGhM3vC8hzgXdLA+k2ESNTsKVLfecR2sX8BZdIABsxHXtpik2FKaQTjCwJKOPR
	 eAho38HI5YX3Q==
Date: Tue, 17 Dec 2024 04:06:08 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] firmware: google: Constify 'struct bin_attribute'
Message-ID: <Z2D4sM7QGLVD0wbe@google.com>
References: <20241215-sysfs-const-bin_attr-google-v1-0-e5c2808f5833@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241215-sysfs-const-bin_attr-google-v1-0-e5c2808f5833@weissschuh.net>

On Sun, Dec 15, 2024 at 03:49:08PM +0100, Thomas Weißschuh wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Please also note the remark at the end of the vpd patch.
>
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-firmware-next

[1/4] firmware: google: cbmem: Constify 'struct bin_attribute'
      commit: bf2066caee80c1612cb5a3356dc16a7a298f58ab
[2/4] firmware: google: gsmi: Constify 'struct bin_attribute'
      commit: 7da14dea76fb6a90f62938e6dfa9f34c980af358
[3/4] firmware: google: memconsole: Use const 'struct bin_attribute' callback
      commit: 093d752032f723da665cdaa6077ee62b3931e48b
[4/4] firmware: google: vpd: Use const 'struct bin_attribute' callback
      commit: 7543d5702c2cfe0e8e8bc8bf4fe8cd44f08d6d39

Thanks!

