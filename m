Return-Path: <linux-kernel+bounces-182770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CBE8C8F92
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 06:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59BD62831E7
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 04:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FD29460;
	Sat, 18 May 2024 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2YoK/nvn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B31FAA;
	Sat, 18 May 2024 04:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716005547; cv=none; b=SgilxWD+8Z24baqaHNP/zdPayL3R892XrbbZn4aoEWEidVAGVW1Awui+Y/Wqxi/K/rnYA4I1Cr5wWuIlFzaUJoOU9ZS9EAiErfxlKyUh1kB4M1Afl/gqY3iH6FDiZKscRUj+g8/Bj7ffz+eNOg6s0MgQmlR82DCo2h6G54pmv5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716005547; c=relaxed/simple;
	bh=XIbT8wEYvM/DpOpagPH3dC8pdPyMCxezidi0LuZ+FDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gd2hX5P3dZYopGafhgO4u+36f2sbn+NwvVtEJGYWYi7tLZyoX/X6aDBPL6VQp31s/VlMeifDjw40x8fYKSiSXkeUugjtr+I+6HpUU/S/bCElnr4XglSXEcPndOrCE3fs/sqcyzx+2EKM+OG2ojzt+aGWzQT4Z3TbPvoFZHR6E9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2YoK/nvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AF5C113CC;
	Sat, 18 May 2024 04:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716005545;
	bh=XIbT8wEYvM/DpOpagPH3dC8pdPyMCxezidi0LuZ+FDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2YoK/nvnAfDULbCK/lac2cN84wX8L7kwvaNHSMVTanighc0FtS2ratw8R5/elHR0g
	 n/IQnwt1ik61FbqfOufwb0x1LJ840rNfaHrnvtm6SkJJHH+lGa9vom8GVznjLVe1lI
	 3JAgHPGQrMM1uuAAcJiIO6uXqg+A7rNPVFx6WQuE=
Date: Sat, 18 May 2024 06:12:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michail Tatas <michail.tatas@gmail.com>
Cc: vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
	elder@kernel.org, outreachy@lists.linux.dev,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: audio_codec.c: Remove redundant
 parenthesis
Message-ID: <2024051806-prognosis-molehill-fccf@gregkh>
References: <20240517233806.36849-1-michail.tatas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517233806.36849-1-michail.tatas@gmail.com>

On Sat, May 18, 2024 at 02:38:06AM +0300, Michail Tatas wrote:
> Remove unnecessary parenthesis as suggested by the checkpatch.pl

checkpatch.pl is wrong here, sorry.  Please see the archives for why.

greg k-h

