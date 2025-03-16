Return-Path: <linux-kernel+bounces-562998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E347A63589
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 13:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D2E16E0DA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 12:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4424A1A3AB8;
	Sun, 16 Mar 2025 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv2xVNDj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EBA19E82A;
	Sun, 16 Mar 2025 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742126744; cv=none; b=mApfyMj5aqExhY4dM6BKh+bXI/fLQ3+i5GtcI3rw+/HTIcUyAr/ElWMXmQmwnuccVDc/EVsNc4yR4z2DMXR7N77Qz/irGD41yuQXyh8CLJa4Vc+0u/QSYH5QOo4ZaLyQLSwRSCjni0mGi17ftN02IisEgLZRfa2J7Oh1rPZBfo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742126744; c=relaxed/simple;
	bh=Hhy5tz9WYqyXX/hh6WuU7HndWxAruJCis/l7khUCgeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opgAw129hNlxUfi/J/GSW5vgNbVFIa63erS0UJsraSowwtOAEY+PvFZpqqt0Hjbo95Xls+29wTv9rbyJf/ea6sNOQP8wCiQHK4TyeNyQuBCN1GFNknGwPAttsk5Ey+UpWSs3xTmWgkgV1C/O9mtcTUzXQ3pjgOAFA8w0TvfN0xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv2xVNDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03235C4CEDD;
	Sun, 16 Mar 2025 12:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742126743;
	bh=Hhy5tz9WYqyXX/hh6WuU7HndWxAruJCis/l7khUCgeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kv2xVNDjLT1NsxHbILNUSqPD8IQDvo+ZcgkIuPjqLGEytsLqDYTP5oBOrGC1FovqJ
	 eeWgxLP0WmdxxWOHbokCWgyOtKPzFtm/foVI2AM4W23nd58aI9iXwriMJDPOVFAwd8
	 vqdWaYqjlJuLT8T43lCR2zAbb+PUVMJ6oiEciYDNKhijphnXZvD2fNS+KYrprueBV5
	 qYnPcY/0zcRELao6vJt0153cef17WdXAMFa3szVYlW+FpZaygMc+x9Zo5T/ll29O+7
	 H4eHKZKZ1+VzW8rscOagpAQWh1OHiDgVU6rk+xOYaGS4ruIJNrhV8xPsgM415iEVYZ
	 fsu1JREkSWqgw==
Date: Sun, 16 Mar 2025 13:05:39 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: driver core: mark Rafael and Danilo as
 co-maintainers
Message-ID: <Z9a-kyMndNJARdy6@pollux>
References: <2025031634-playing-lark-95f9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025031634-playing-lark-95f9@gregkh>

On Sun, Mar 16, 2025 at 07:07:35AM +0100, Greg Kroah-Hartman wrote:
> In talking it over with Rafael and Danilo, it makes more sense for
> everyone to be a maintainer here, to share the load where possible.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Danilo Krummrich <dakr@kernel.org>

