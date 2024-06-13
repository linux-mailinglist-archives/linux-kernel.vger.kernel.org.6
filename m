Return-Path: <linux-kernel+bounces-213389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D5690747D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551F01C23AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2552714374B;
	Thu, 13 Jun 2024 14:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ciXSBnat"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CA714265A;
	Thu, 13 Jun 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287224; cv=none; b=VfrFIN7Nyj8YFWz4dNIN5mqUi2lM9uF+q6Dmu6XMkJJ4aliuIUm14K0uNxJaFlShfHvv3/g2LyJcJ7bdMi0sWx5AFJVVabSAoAn+qgKi8W+qc6j0BYuSrm5Tia8blRTHnCv7ySyOlrLr42nhaIFajs8kj1wR57CRqCKzt/PWfLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287224; c=relaxed/simple;
	bh=KfGULQmDsy4xtREQtEVVibSIPG7lRPWl4JS1dcUTD5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/wB0DBe51tU4DINm+QPylSCQm9Cqp5VYFAEEueKglFcA8SPjR1SYXaPm6tO8JABwriKiihyIBGp6GxAt0d1AUbIJf3Xer0pPkCTp/Ovhf+SN9tB+JerAeZk5nVNrEsnFtbn6r6cwlSFaQ0QycgbgcaHDeQqujIRKm45Jt3vhrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ciXSBnat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D42BC2BBFC;
	Thu, 13 Jun 2024 14:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718287224;
	bh=KfGULQmDsy4xtREQtEVVibSIPG7lRPWl4JS1dcUTD5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ciXSBnatRV+ezL2tZ7CczupLRroB4JKvY8iirYNxtrbYN1ujKhqDI4NpQlveMxFNl
	 4XUpXXDbIMZAhBy63XFJ3SR+XdZ2IgKbnad8BA0NMH2HqKSEGLNLcrW0r33uFbTnyG
	 PifSLfLusiJ/lJHu/fBA4hQ9gjubPwYVzs1ELAAQ=
Date: Thu, 13 Jun 2024 16:00:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org, Tony Jones <tonyj@suse.de>
Subject: Re: CVE-2021-47543: perf report: Fix memory leaks around perf_tip()
Message-ID: <2024061337-delegator-chafe-bf6d@gregkh>
References: <2024052439-CVE-2021-47543-a01a@gregkh>
 <Zma6fJmtaz8vgae2@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zma6fJmtaz8vgae2@tiehlicka>

On Mon, Jun 10, 2024 at 10:34:04AM +0200, Michal Hocko wrote:
> As far as I understand this is a bug in perf (userspace tool). This can
> occur when running 'perf report' which has a generally short lived
> lifespan. Is this really a CVE fix? What is the actual security threat?

You are correct, now rejected.

> Btw. CVE-2021-47545 is another one matcing the same pattern.

Thank you for noticing, also now rejected.

greg k-h

