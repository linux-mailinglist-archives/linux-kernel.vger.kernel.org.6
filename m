Return-Path: <linux-kernel+bounces-237786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F207F923E15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989D91F2375A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845B216B753;
	Tue,  2 Jul 2024 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/sJsjlr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0F9470
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924307; cv=none; b=p747q5jAd+WJQpGbqSGWLtSbIwOXZTf2CXkQ+5gOnC/Kplx7jcP9GVpbowlWoe4aNR2eYLftV9gUtzpdCMZ+j6nmPgt9BvEK3woI9zGQrhDIEitudsF0oHG65fAT0EM8FVY/QQcXaZJ9hEK2aklc9uARuFJQzp7RPFvlNvt6uIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924307; c=relaxed/simple;
	bh=pnuX9yl56FGqRByedK9TL15vS+LxSLN3/RLNaQRaNyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBFYDkwk+xCU6aKn0EkBNA+73Cs3X9AQ7dtoRpELdqxORiy0NLJmLF3yKSE4P+fJvZPVq5FDJ4UYqyb9CvHSo8fJ1ODRN707vkypxjmwUlVDQ2U3KAcV8rAyglMURfwLK3wzRRcCMNvHU0ocftB92i3X1zDhCBPSrf2EqQrTw0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/sJsjlr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07EA5C116B1;
	Tue,  2 Jul 2024 12:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719924307;
	bh=pnuX9yl56FGqRByedK9TL15vS+LxSLN3/RLNaQRaNyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/sJsjlr2MDJ+EZ33K+iiyyYRC25e4ulxcgtRpn1yaGXVwy9+y6vQH+bVx9x/AZDt
	 DcG/gg1oHDJHMkmOZ1ggP1kVe2+TQlYIDuifeCa/MsX89VOfgghXcSiYsK+kLQyAyC
	 1qy+Z+kUKKY/dGh5Z2t7zFoQvhlN/LkVUYabcX6Dp8w2+M3JGBXctkeSzRv9s1mpcP
	 G93+8w4jIM5CAv3MYSoAFnwUfugxDGb+1EIZ3VgJBKaGAGmVP2n5RjF85lHK2HaNSJ
	 egdZfJPviq3GS8uB/EGKlGo9RHT8o7X3jvdbZ10qHsQ6sNGrSEOZxU7Ws4W1JSqGQl
	 JxdNEcdnXHaIA==
Date: Tue, 2 Jul 2024 14:45:04 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] timers/migration: Rename childmask by parentmask
 to make naming more obvious
Message-ID: <ZoP2UMF0iAECnbBD@localhost.localdomain>
References: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
 <20240701-tmigr-fixes-v3-6-25cd5de318fb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701-tmigr-fixes-v3-6-25cd5de318fb@linutronix.de>

Le Mon, Jul 01, 2024 at 12:18:42PM +0200, Anna-Maria Behnsen a écrit :
> childmask in the group reflects the mask that is required to 'reference'
> this group in the parent. When reading childmask, this might be confusing,
> as this suggests, that this is the mask of the child of the group.

OTOH ->parentmask could suggest this is the mask of the parent of the
group. I'm not sure which one is better. ->childmask never sounded ambiguous
to me so far.

How about ->grpmask ? (deliberately stolen from RCU's node tree).

Thanks.

