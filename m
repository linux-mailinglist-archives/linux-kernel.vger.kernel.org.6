Return-Path: <linux-kernel+bounces-325008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F08CA9753DB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2991A1C21613
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20501A3041;
	Wed, 11 Sep 2024 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="viJs73MB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374EE190667;
	Wed, 11 Sep 2024 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726061082; cv=none; b=TTuoG5US63f1YQK1dOE31iZGWzKakSbb9iGvx+rxfk+lcrePBJFIRGWqUjbYhaY4p0BuAOlG5EgWCfty4fuup8Yfm/xUp2Z/l115nUl4q0vjKc1G4J55wgEjNdR/MwpjnZYKTs6s6m3qJDIJEan/Dk5LuxXpCoxHaD1gUF9XriI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726061082; c=relaxed/simple;
	bh=0rLIMi6iPg52caMXkRzgxW+7Gt8Yg29GRT2WxbllgWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhMKm1zICISAwK4hUHL7A07EFqnUuD59hqIHGlCK8rAzuL8Dq8+1wF0vDp69lC+HPFsakIk6ZJpaS7eA1ofRPqGIgggsbgE/kNwl/E2WxD1NiN/SbNyO5Ij+Dmc52P6HFFDOHxYMKXn2RMsyk/cdC/XefYWeEir1QznFQFG5Hhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=viJs73MB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3DBC4CEC5;
	Wed, 11 Sep 2024 13:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726061080;
	bh=0rLIMi6iPg52caMXkRzgxW+7Gt8Yg29GRT2WxbllgWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=viJs73MBfFrWOql6ZVKPqc7UmfUeyzizGpmKivWxT108wFP5FczuA+tW/HMkDOSCF
	 1HWwFm/Ctuh7RW9Xr222ojqcsJ5uAn/vKHO/5OCFN3FXPSOOl+AAbkuz+Y2gREJeUH
	 or+CxznzPz2wqw22QoSJcrmBGe0scqBtcYVDZaws=
Date: Wed, 11 Sep 2024 15:24:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 6.12-rc1-2
Message-ID: <2024091114-duplex-grit-f5a7@gregkh>
References: <ZuEz67ehYXIG8AXB@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuEz67ehYXIG8AXB@hovoldconsulting.com>

On Wed, Sep 11, 2024 at 08:08:43AM +0200, Johan Hovold wrote:
> The following changes since commit 431c1646e1f86b949fa3685efc50b660a364c2b6:
> 
>   Linux 6.11-rc6 (2024-09-01 19:46:02 +1200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.12-rc1-2

I've pulled this into my usb-next branch as it's too late for 6.11.

thanks,

greg k-h

