Return-Path: <linux-kernel+bounces-292667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B585995728A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72109283DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C92188CBB;
	Mon, 19 Aug 2024 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="NClCAvsR"
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF2C16CD0C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724090262; cv=none; b=WBDmRDwKJ2I0FxsMNL7OlFfi45LtpW0BQjIfYyXxOIFpMehd2DOkOAbR0JXXt7dSqAp8Po/TgO7yNKYe8ACAhDuXTKYr4j9ksX4BMI4GcWXlde3h2ZL7VH5R0y3c91U9VHg9BiFi6rPXqVlM0Knh5oBDK4JaTceSrQOkJKTOR4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724090262; c=relaxed/simple;
	bh=o35qCvEZbu4T5kA4SvRlTOdbqIKV9iz8xf1om4OGwIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iv3l5B2Iw12g81jIPmqwllBPIQFjIncLZNceEBazPlScAiBs1+VTpK7VD9QGhGu8YDK0b248AbsblUhyRUAg+szawp58ibgTVMH5+uVRqDCwkrWGgWmSVI7VrAN9Vm947h8Kovy3vogRTxCmcqMQi59bevJi25FCw0/e+0P8008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=NClCAvsR; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WngKk3dMMzxMs;
	Mon, 19 Aug 2024 19:57:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1724090250;
	bh=Mkv7N3eK+fsZD7USRF4qFft68VEC4BZLCWR/hmSXw0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NClCAvsRfZN0erdn5kwTp7MikRRs9KgfMhRrRWHxPHG6afsYPRuJe3pZMUds/pkJw
	 W6WZCKmnvwHsIEHemS2lzqHUixQdgw8HdKs7xrdB8AcebslnEufnL++Q/mYWXvaxCj
	 3ioiU8Otfy+lyH06pHvw2peza0KgU1Gf9Tf0QYto=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WngKj30pnzgrn;
	Mon, 19 Aug 2024 19:57:29 +0200 (CEST)
Date: Mon, 19 Aug 2024 19:57:26 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: outreachy@lists.linux.dev, gnoack@google.com, paul@paul-moore.com, 
	jmorris@namei.org, serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/6] Landlock: Adding file_send_sigiotask signal
 scoping support
Message-ID: <20240819.eiDie8sienah@digikod.net>
References: <cover.1723680305.git.fahimitahera@gmail.com>
 <d04bc943e8d275e8d00bb7742bcdbabc7913abbe.1723680305.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d04bc943e8d275e8d00bb7742bcdbabc7913abbe.1723680305.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

On Thu, Aug 15, 2024 at 12:29:21PM -0600, Tahera Fahimi wrote:
> This patch adds two new hooks "hook_file_set_fowner" and
> "hook_file_free_security" to set and release a pointer to the
> domain of the file owner. This pointer "fown_domain" in
> "landlock_file_security" will be used in "file_send_sigiotask"
> to check if the process can send a signal.

We need to make sure this file_send_sigiotask hook is useful and can be
triggered by user space code.  Currently, all tests pass without this
patch.

