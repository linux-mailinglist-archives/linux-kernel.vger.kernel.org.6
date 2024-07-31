Return-Path: <linux-kernel+bounces-268522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EE09425BE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 07:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8A21F24480
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F14249627;
	Wed, 31 Jul 2024 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u5PPaDad"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674073219F;
	Wed, 31 Jul 2024 05:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722403724; cv=none; b=HjIg6zJNO2J+Ny+EQA7UU4h3bSkB0kSmmv3OQIyYmVk91u6vrCfr/0/KQ2FZCgQgRlRRemNyn91SgOwwHGiu+6P5TlvajiWwnOUs5VkcT1AVeHql0PMirgQnMJ2H2t0ruhQtOBm5siqN0gu1/TZi/2FxnxFy6wVI1tp9NnjmOWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722403724; c=relaxed/simple;
	bh=HPuywlvRMMs49n1oKFWIqI2nwrMsV7CxvqH3WvnigiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRrE4IjFm/gmW2kumb6UjLeRU/O8TZt1dWz2Lnl0b9R+nRLdyBhznQqmylpUM52CM6RMqUVayojxiRphSnltMn9NLCvWyusE3MlsM4eLQAYWgseEv1QZ1bz40gqmP+wHISX5/231vTWEopyO3MFt3EPfz27gsKET30rTfoWdDO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u5PPaDad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AC1DC116B1;
	Wed, 31 Jul 2024 05:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722403723;
	bh=HPuywlvRMMs49n1oKFWIqI2nwrMsV7CxvqH3WvnigiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u5PPaDadrzTVYDFeYwS2wsCgi5eiBTohNYSEgvffu3GCDC5lWlIh4Fb9Gm9e1PHsX
	 ezYkHOs9X+CRC+666r9K93MHFm5EMbMC/rhQeFf1g1TmS2B6g9PNclU/u0URA8J6ts
	 ZN5Q4+7yF6XwAfR8nbTrflBUPJsEZDYgJsypewHk=
Date: Wed, 31 Jul 2024 07:28:40 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Manjae Cho <manjae.cho@samsung.com>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Improve MAR register definition and usage for rtl8723
Message-ID: <2024073116-unlucky-vacancy-b323@gregkh>
References: <CGME20240730155255epcas1p4ab3b5e88d400e2221aa1cf5cf234ea19@epcas1p4.samsung.com>
 <20240730155054.411059-1-manjae.cho@samsung.com>
 <0812112f-a06d-4ef1-8ca2-468973191ca7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0812112f-a06d-4ef1-8ca2-468973191ca7@gmail.com>

On Tue, Jul 30, 2024 at 08:55:22PM +0200, Philipp Hortmann wrote:
> In case of questions feel free to contact me directly.

No, please keep discussions and help on the mailing list, direct emails
is not a good way to do kernel development, sorry.

greg k-h

