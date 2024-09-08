Return-Path: <linux-kernel+bounces-320297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1309970879
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B744E1C21028
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C54E173355;
	Sun,  8 Sep 2024 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xQTrSEU4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8062134AC
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725810604; cv=none; b=TE0fG/RR+fKym8nQVL4y0bjuGhpOFh2EDVCe1msPPUpRw5HiZ4Ru8vgfvvnwSAQXXxwzd6cF0UvF1IHAa99TkUUb7bJOVffKwEN16tuM0vi6UacOIK8H4m7XrAsPKxMZ2jqCja7JZAnkKDT6JqCoDRnwVXQ0BfC3J4n2DRiTPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725810604; c=relaxed/simple;
	bh=3BruFAXVq8RX6cMi0k/zTXL2TXSy1HASLmWj77Yztik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xn8KVLbFKDGDZKI46cjth8G8Hhh/lbaiNhvaBy4mDC8zohIOHX4SYhI17qhug03hu+cLv4yksA46H4s/pjmRj3xdqTaYYvXhxlspmDxSctD/A+pCvcRABNs3fCgD7gSG390wBsKZ9ZA/RYG/bqpW0kSbXAOPZquo8jEm/xucVuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xQTrSEU4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1092EC4CEC3;
	Sun,  8 Sep 2024 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725810603;
	bh=3BruFAXVq8RX6cMi0k/zTXL2TXSy1HASLmWj77Yztik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xQTrSEU4o/YqDUXUgna9NJIJJvrUtfcsekawvZChNY2yU+veV162LS145kAWMlkZO
	 46NlJMgikPZK/bOS9nqFUF6Zhkc+PHhPAGuA9lmOVRddhawzvdnCXh1RbWMMi7mfcw
	 K5etVcrrPDjH88HZa/UvpUlz/gbBayzbRV0dHUEo=
Date: Sun, 8 Sep 2024 17:49:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v6.12
Message-ID: <2024090824-unmatched-grueling-1789@gregkh>
References: <aac3f30a-bab1-4a45-a69d-050b15ead4a8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aac3f30a-bab1-4a45-a69d-050b15ead4a8@kernel.org>

On Mon, Sep 09, 2024 at 12:18:11AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v6.12. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:
> 
>   Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.12

Pulled and pushed out, thanks.

greg k-h

