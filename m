Return-Path: <linux-kernel+bounces-254556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 349A29334B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 02:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA7F1F21309
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F8BEC5;
	Wed, 17 Jul 2024 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUJaMDt7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A57803
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 00:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721176094; cv=none; b=BpQ8bc98PdFuOlMWB3NfOVGF4xux1GJXYJDT1geNE022b9GcmapJekiVnNyztWovhreDqwUdUeDfONR/wP1TPLWoVMJv7gugfkS9VxCYdpwqz9aC3oO958+ylTZMJ6iC6Q55BAsW0qCYV6O/5TKTiTmnzpgrd8tcezPTwu2M4LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721176094; c=relaxed/simple;
	bh=hq1sNOsgV7k1yY367ghW4KSWzOrVyj4GNTa4KoWvMJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISKT53tc+0FjGwngQn2MF+uOt/n6Sq/z7PMLs/S0S0NZSd56Tbkzi+A4nPVfz8RvXzrfSj/uThdGYat/Eoz2olHbxnVLcE4Qn2/6cc0OEJ6CCpYrszbl2/qFvvXxzg0Rs9bk31EoP6nwcoX9jizwDSSnhESBzZ9h6gFBvPLCCMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUJaMDt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C84C116B1;
	Wed, 17 Jul 2024 00:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721176094;
	bh=hq1sNOsgV7k1yY367ghW4KSWzOrVyj4GNTa4KoWvMJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUJaMDt7oFMPlW5BnFs1BBhPbjzD+fszT4/RrFtNUeGtyBdwA8O053PO1Q3yNwdNW
	 82xUxQNxCzb+/jJGKfIQQ9vmmrNz4aU4C+Ry0bBwnoYo/0nqXbwe2te9s/LTn3JPfl
	 RbKl5X0Yu8G3xkLNFulSK/5rbVh48GQ7xhlzCEr6ytcqwGfe6nqlUjt6noLznDB/FT
	 gk9Yxor9nIxwsuDDJ0EBBmYo5dnpHTl1s8qE1zqvzlc1xfeH/K5Z/0RARhD6q2Y0Z/
	 G0FsrgAXsCP78YEfUcr6hFO9UNM6XAXLRwLFMcqz56uFKDl/DyghrwGpBS+W8uuvQH
	 P1oITnmbEF6/g==
Date: Tue, 16 Jul 2024 17:28:12 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH] misc: Kconfig: add a new dependency for
 MARVELL_CN10K_DPI
Message-ID: <20240717002812.GA1692174@thelio-3990X>
References: <20240711120115.4069401-1-vattunuru@marvell.com>
 <20240716132603.GA3136577@thelio-3990X>
 <83ac6b91-c7f1-4b18-a522-8188d6d1298b@app.fastmail.com>
 <MW4PR18MB5244F75E2D16051A5B838FF5A6A22@MW4PR18MB5244.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR18MB5244F75E2D16051A5B838FF5A6A22@MW4PR18MB5244.namprd18.prod.outlook.com>

On Tue, Jul 16, 2024 at 03:33:49PM +0000, Vamsi Krishna Attunuru wrote:
> Thanks, Nathan, for reaching out. Could you please advise on the branch where
> I should implement the fix.

I assume char-misc-next, as that is where the broken changes are.

https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/log/?h=char-misc-next

Cheers,
Nathan

