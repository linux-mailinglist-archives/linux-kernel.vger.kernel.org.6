Return-Path: <linux-kernel+bounces-262485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4025393C793
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 19:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE6E7B20B55
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3E719D8A7;
	Thu, 25 Jul 2024 17:14:47 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18AF19B3F9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 17:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721927687; cv=none; b=BwIyU0iXjyLPccB6EBmXsFRithRYN+88+97OFyxvLtsqZVsb8StHxPIUBBQWwqV0jsRlKs2z/bTFOoicw2p1ohP6BmORDyZW8fEk5RCZh1/eWYvquhpMdzCf2ySDAZEQVBTg9XicLEeDJ9fr1YLqyirjF8tMpjtgAWWvbcuRSy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721927687; c=relaxed/simple;
	bh=CNk/DQuHy42B8dpzVfkzz+ODFYNL+SclierQzdBXmJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pDOn4AI4J4I6/H1Y229UDaIaAxUnSAnM5GicFExfqkkva9v9BjJZZ68E3sIvbvi75PVIgmM+L9MLledk8oLtiQAHf5gS6TqQFZ1kZIDvdUYuz1Y+TffKXA9Xoc6UXLqgMOaaUezzB1IYZhYAiLVO4/Ve/KDdkt0UoP9GGAvTEgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 46PHEhId031037;
	Thu, 25 Jul 2024 19:14:43 +0200
Date: Thu, 25 Jul 2024 19:14:43 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: add stdbool.h header
Message-ID: <ZqKIA0+hEc2lE8gF@1wt.eu>
References: <20240725-nolibc-stdbool-v1-1-a6ee2c80bcde@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240725-nolibc-stdbool-v1-1-a6ee2c80bcde@weissschuh.net>

On Thu, Jul 25, 2024 at 07:10:44PM +0200, Thomas Weiﬂschuh wrote:
> stdbool.h is very simple.
> Provide an implementation for the user convenience.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Acked-by: Willy Tarreau <w@1wt.eu>

Thank you for this one as well!
Willy

