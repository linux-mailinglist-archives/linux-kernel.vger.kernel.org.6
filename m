Return-Path: <linux-kernel+bounces-556534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1391BA5CB74
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A84363A78C3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94969261590;
	Tue, 11 Mar 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rYzetFOo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657726039A;
	Tue, 11 Mar 2025 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741712339; cv=none; b=khG5CYGgvExBg4aE1cDylHRzpAQJLR+u1JXRAU1DjDZgFPc/X3Axia3jXdL/5d/O+s8/UjnDkqPNFtkjDiP50gsYz9RRzo1kxD7v+AK/eAanQ57qlAs7hq+qZF8oP8B5iSE2thvG04EIa3qRxmWacsM05N0nNc+qo2Nri6ScYQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741712339; c=relaxed/simple;
	bh=Wr1+ZXAtwYarJZo8X654ixYjsImjvfCtoz3kCMzeguw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhPDl3Q9lLGzzuWBRhmBvyYJiLPv2R2jvxu2WC6D9RG5xLvby4Z6t3y0e7M3uu/27J+wwFeN2iio+4kw9bi5HRSNrKl7vQUr6Zc7YzFpMV7+WZZjTNuP/XEYMKNsDvbrJ1eylxi0Y6FNtFrNG1a2L6lHkjgUCQ/4+b+zyNHgHGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rYzetFOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB98C4CEE9;
	Tue, 11 Mar 2025 16:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741712338;
	bh=Wr1+ZXAtwYarJZo8X654ixYjsImjvfCtoz3kCMzeguw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rYzetFOo66m43HK07pKh7IkOInAl3j8qfFcUYIO1p8sX9QKu8ZYwdOqoE799137Qc
	 YiAb0tzxLhuWH4TzgZPwLzt2kXXkFCUjxeTwETlzpdY8uCPYLO1TaL7zc1tP6XgoN6
	 POuQ10brlQf2vX2xgpk0V4c6+OWGYKoE3FYCFnNU=
Date: Tue, 11 Mar 2025 17:55:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Suraj Patil <surajpatil522@gmail.com>
Cc: oneukum@suse.com, stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdc-wdm: Fix typo in comment
Message-ID: <2025031145-erupt-earring-335b@gregkh>
References: <20250311155712.467380-1-surajpatil522@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311155712.467380-1-surajpatil522@gmail.com>

On Tue, Mar 11, 2025 at 03:57:12PM +0000, Suraj Patil wrote:
> Signed-off-by: Suraj Patil <surajpatil522@gmail.com>

Sorry, but I can not take commit without any changelog text.

