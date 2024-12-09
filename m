Return-Path: <linux-kernel+bounces-436662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EE09E8928
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 03:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADAF3188660E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 02:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35F63D3B3;
	Mon,  9 Dec 2024 02:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDNHGitm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F2B66E;
	Mon,  9 Dec 2024 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733710847; cv=none; b=IHQvu3tLnE59JQ8ka9rETQTHrmjLODhRwfFZn6JmVNQesNeQip3cEdqQCh4au50n9RKLJf5Rs1964ecqpf1sOdd2E0DwRJe8eAviD76rLl5ekdllUxbOeRQly0qP5QCUX8W/Isv0CVotRs2wf5tiaNE4eRG98OOlIQNN6VSr8iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733710847; c=relaxed/simple;
	bh=NW/0AnpVZYFNsaANc1AZBCYAwwQEYK/rTc7tMz0pn28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i39PKBvy7SDeNxMKERYuhk7/ymo3GMHs4k+5tXDcQ39Fr3OJa42p7AN37rEVoTOiX6R4U5YFilqE6qAoFPkRg6EpN9pi0vR/smIkoX8lhjRa21Dyjb112V2GVAD8QHoq/tfQoiThHt35yXUq+Pq4F/zY0ZDGYad+5ucE4uxIs1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDNHGitm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41FCC4CED2;
	Mon,  9 Dec 2024 02:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733710846;
	bh=NW/0AnpVZYFNsaANc1AZBCYAwwQEYK/rTc7tMz0pn28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDNHGitm/8f2Tk+rbCAS69m0xLhD3B2/tXOJRKU3gFGmznlghGGukbqtNYXqqvPyp
	 SaDaintKZYAZWOm3GWFKehRUE0gcLNVJms/ka67Dq2nxkmTZ1/4XwcDg/w1ymwn4XH
	 lEd+s1SxQ+7UVtw7wWy4rxBSNuTyLHsmzwjQHVywoWAgbfQ9FlP9YqvlzvfnOZ0ZpL
	 i7SKwC4PjyXAQC2Gs7dWbIQrykHoq3+DqmmxHsbqt43gypwaU9XSmqdNRJ3WL6wP3E
	 gjDPCf249KDJ1RzMI4Uw76Ndj2DJTqRCIZQni9NZnqrz2lC/NYuatFaHwsd/8bux2f
	 VeFqurysg8Wvg==
Date: Mon, 9 Dec 2024 02:20:43 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Dawid Niedzwiecki <dawidn@google.com>
Cc: Benson Leung <bleung@chromium.org>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, chromeos-krk-upstreaming@google.com
Subject: Re: [PATCH v3 0/2] platform/chrome: cros_ec: improve probing for
 RWSIG
Message-ID: <Z1ZT-ytCFmOvrFu5@google.com>
References: <20241206091514.2538350-1-dawidn@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206091514.2538350-1-dawidn@google.com>

On Fri, Dec 06, 2024 at 09:15:12AM +0000, Dawid Niedzwiecki wrote:
> V2 -> V3:
> - Move exiting from `cros_ec_rwsig_continue` if `error_count` exceeds
>   `RWSIG_CONTINUE_MAX_ERRORS_IN_ROW` to the `if (rev < 0)` statement when
>   `error_count` is incremented.
> 
> V1 -> V2:
> - Use dev_info instead of dev_warn when cros_ec_rwsig_continue returns
>   an error.
> - Return immediately from cros_ec_rwsig_continue, if the RWSIG_ACTION
>   command fails itself, not SPI transaction.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/2] platform/chrome: cros_ec: jump to RW before probing
      commit: 4b308a1944b8ff1d50131849372672396a799a37
[2/2] platform/chrome: cros_ec_proto: remove unnecessary retries
      commit: bd37caa72a61fea3c1ddf465ed1b122b6a613349

Thanks!

