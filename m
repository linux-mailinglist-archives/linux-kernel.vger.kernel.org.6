Return-Path: <linux-kernel+bounces-447586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5D99F3496
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C5C1619C6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D696E148FF6;
	Mon, 16 Dec 2024 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TJuySMhx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D50917C64;
	Mon, 16 Dec 2024 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363191; cv=none; b=XwRjs9eewfM8QXSWgCSHmHE9DFMG3W1a0seiIt99PieL3Lir40D0FvkIYIN9QWAK+WPdX91PzFZBF+/x8IUvZNLctiko1Pu7HrCgBlw18UkI2Hi4nTbKRpbNwlTV0oz9/IrfGsEe8bit+pz6WDHSNtGBHxHWzL8IOQcs80kl4KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363191; c=relaxed/simple;
	bh=TBDuBtcJtvuCMiGgCQ8hcCb1YR11UswW961xLW7Em0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Txv/lFLuKUgvdazwMy/KcdtuCe3L3iTFpB/X0nuuURRQa/oC9A7AyLNX6oVJSJcnAEUOw2RKzKMw8v03kTEvXs4g+un1qLDHhS1oWpu7QNXw8W0r/o9DvADs9i4DO8k1lf3uQasByJEEynazHL4wmWXs6x5FfoEe2LNlHhIUYlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TJuySMhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D87C4CED0;
	Mon, 16 Dec 2024 15:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734363190;
	bh=TBDuBtcJtvuCMiGgCQ8hcCb1YR11UswW961xLW7Em0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TJuySMhxyDjjmqRsRGGWgzwp+zNtLWJFokA0BaSJG5Wd/0X5q5O3mQzk4ME1cbKP2
	 u+RsMDSnQDtJZrXZfVuNmGu9z19cgtEEt2Jyav18ilWuK+7xGaCuJU5WWmoICe5MP6
	 2PjWtwG+7JigmljFt1K2Xm8L4zK4kBVawVsANwLo=
Date: Mon, 16 Dec 2024 16:32:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial device ids for 6.13-rc3
Message-ID: <2024121609-relapse-relapse-b295@gregkh>
References: <Z1vuzdjd6mSrgrZq@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1vuzdjd6mSrgrZq@hovoldconsulting.com>

On Fri, Dec 13, 2024 at 09:22:37AM +0100, Johan Hovold wrote:
> The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:
> 
>   Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.13-rc3

Pulled and pushed out, thanks.

greg k-h

