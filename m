Return-Path: <linux-kernel+bounces-373136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5959A52DF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 08:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B5C1F21FA1
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 06:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2C917996;
	Sun, 20 Oct 2024 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DGXmEkBb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BD11078F;
	Sun, 20 Oct 2024 06:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729405068; cv=none; b=McooZtWt7wAyoSs/Zk+X5pUomDtCxtvYs8dHygZRPf1CtevcCQxRuKpt4LsB3J565jnndnTsyBJWdC4Si+acxHjxj2WexLWsq1kBvxEqu4JNqSuqo716+HcjOg6wJ0ZL2Yip+wIvQOK3YRBK89qdFig3KOr/IlTmG1JxsCz3rxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729405068; c=relaxed/simple;
	bh=G/1xgmvmCVD6P5EbRSlcwDqkGQuE6FYxtj7EawHoTsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvyh4xaE4D2AQgqzKov0w88SkvHp9qJD1f2kRNTpUquJD06uhzpCd+Jpr09x04zdwGqSr4pJy/+NXbSHc9x7hi0GRlFayBakWtX89hX+ujENnXVwYtbU9g+a+wtmX+TL2Hw1YJUZHixFojgGZPGRBnnE4aYPdV7CA9thPYv4TSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DGXmEkBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48F8C4CEC6;
	Sun, 20 Oct 2024 06:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729405068;
	bh=G/1xgmvmCVD6P5EbRSlcwDqkGQuE6FYxtj7EawHoTsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DGXmEkBbSpYbw68XATKUIDRmjQGkZR1iz9ATYk7/MLr1cQ1brWvo1c169o9PyERpm
	 HWLfaqaorf1UNxw2Wah4bwXJYMjCLl0wBybH0jRKNm8Uc6S0ay2yu0ItVQluOwhCcY
	 QcCE4g+HK9LcOOTa6CZhk1ohm3ejp6mZ+YEXRm1w=
Date: Sun, 20 Oct 2024 08:17:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Grosse <ste3ls@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/usb: Lenovo Mini Dock, add support for new
 USB device ID 0x17EF:0x3098 for the r8152 driver
Message-ID: <2024102028-postnasal-cruelty-8da9@gregkh>
References: <CAPvBWb=L6FVwSk7iZX21Awez+dwhLMAoGe39f__VC=g7g6H2+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPvBWb=L6FVwSk7iZX21Awez+dwhLMAoGe39f__VC=g7g6H2+g@mail.gmail.com>

On Sat, Oct 19, 2024 at 07:37:06PM +0100, Benjamin Grosse wrote:
> >From 7a75dea5721225f4280be53996421962af430c8b Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?Benjamin=20Gro=C3=9Fe?= <ste3ls@gmail.com>
> Date: Sat, 19 Oct 2024 10:05:29 +0100
> Subject: [PATCH] usb: add support for new USB device ID 0x17EF:0x3098 for the
>  r8152 driver
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit

Something went wrong, this shouldn't be in your changelog text :(


