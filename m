Return-Path: <linux-kernel+bounces-391744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8B89B8B2C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 07:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1171F22218
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 06:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6BC14E2DA;
	Fri,  1 Nov 2024 06:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="a13H3l1S"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16643147C98
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 06:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730442079; cv=none; b=oiI4eyPr2c8sYrZeF4tSIpIHQLS2sl0nUg1s+7Sj42F+7tJ7wpTtBz/2HedqYCOK+KN7tx0ab7nRfvN/dE+xKbn7791/mjQGkjvSM69Hhy94Yic8RcsI5jN8BSWi00+mA206CSJFjczMJyYaSavKRtsV2DnQ5hs7H+MjigQ3OHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730442079; c=relaxed/simple;
	bh=+xcRSe7Af/YhaiQmjlGQjqVwE+Ioa2t+/i/XQhRNtoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J+2ExRIZcDJNcTF2YerOhgArTcpcAr7dZMqLbSGNTgNyCFA8+o90YNshhj0wMhCfpSvTdDB+V+A+D6Pi+H6JmrNpqALjakwP2KrRhtBlGHyI533JK2PDTnSwlkHJtcEqVvW1V0NFAO7UOaPQYpanvLD5/jJcqGYOVpt44M1GqvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=a13H3l1S; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id EFCC21770C0; Fri,  1 Nov 2024 06:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730442075; bh=+xcRSe7Af/YhaiQmjlGQjqVwE+Ioa2t+/i/XQhRNtoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a13H3l1Sb/jMcYdJDqKn+pZ7UfntuKH48KExW9Ee5ZIFJoZtJlaOXz70jXppFsOqN
	 +PtqG9IdhBz7MJIy9F7ZWGnQJ56P5Ofs+YXCzxtB3CCyCbQAay7g4guszVNBynfdsh
	 nnO6jIEWdlEcQvQvTlKPvTRTFEFRj5SWd7Dks9gCQ17/ANjmttNV26uPJk3Yz2AwlX
	 GA2EOUDbuGcAPS5A7GAlwO3a93u1xVPi3143hD6bHRlJfaPVf24domVL4uYSs0U6Lc
	 ykazM0dlnwxrp7QnfCm/Vnwz4gD8E9tz2A9AgbVp3DJalzTmAoU5KIRXqlnnoeUwRv
	 3iNf7LCKN9QhA==
Date: Fri, 1 Nov 2024 06:21:15 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Doug Anderson <dianders@chromium.org>
Cc: jason.wessel@windriver.com, daniel.thompson@linaro.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdb: Fix incorrect naming of history arrow keys in code
Message-ID: <20241101062115.GA32320@lichtman.org>
References: <20241031192350.GA26688@lichtman.org>
 <CAD=FV=WC-ce14rgrYsVbg75dNX5tL6Saj5T8YqpAWm2ndLGdXA@mail.gmail.com>
 <20241101002612.GA29456@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101002612.GA29456@lichtman.org>

On Fri, Nov 01, 2024 at 12:26:12AM +0000, Nir Lichtman wrote:
> 
> Evidence in the code for usage of arrow keys in the case of keyboard can
> be seen by examining kdb_read in kernel/debug/kdb/kdb_io.c, in the /* Down */
> and /* Up */ cases the values 14 and 16 can be seen.
> 

Correction: The evidence can be seen in the kdb_keyboard.c file
in the function kdb_get_kbd_char which gets the scan codes from the keyboard.
The conversion between the up and down arrow scan codes to the 16 and 14 values
is at lines 138 until 141.

I am thinking maybe a good solution for this confusing passing of magics
is to export the magics to macro definitions,
or maybe to make the keyboard flow also actually use CTRL chords?

Thanks,
Nir

