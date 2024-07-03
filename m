Return-Path: <linux-kernel+bounces-240216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 606D3926A54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F93B23C3C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FAC191F83;
	Wed,  3 Jul 2024 21:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PInwHvfX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A84191F64
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042430; cv=none; b=lmPCW5HLfa3R+MMhtKhTYg8UNv8+qWeBArx96+CqiVh74bJ5ylw98zx+y4Qoe+TkIfpZvcecopofA8nkrXqPTv/cnhchmfY0qzd4kjMoPW/zy0cwKDCcABg8JOkJhPa6aL34N+c1+bAv2OW5NBLS6QCPESGq4tQOUM8CrP6ZFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042430; c=relaxed/simple;
	bh=0bRFU8OTKfGzN92b+TLqp4Uz/MBx7Hr1llGZewwDG4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEUNd4bgR6QyANmz7DorHrkKVgT2O4kK2/vZbt2M9QyC3ewCBVdE9q4KhMXDdV7bowVQHv1QVHvZ9OkJp3sq/fjniIHYgu2NxB8k966hQmltLb/EqqE5hnozrAnsR1MXFoGF+en0n9VukBnGGiwp1nRvJwFYv4senQzzH5PwCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PInwHvfX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1212CC4AF07;
	Wed,  3 Jul 2024 21:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720042430;
	bh=0bRFU8OTKfGzN92b+TLqp4Uz/MBx7Hr1llGZewwDG4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PInwHvfXc9K5Zpd9nfrP6wLomh+pPH8U6SHmqPVPZ7i6+M5iQkq9UgUbHDrN+WfKM
	 QY871lMa9OYHgJp3F/+zpQlExMhe78OksL4i51rExx9hO6nBtty9q7KGoDIOOgqXCK
	 mcb1hxwfdkUzHzz3rA3rrsfjkX7qTp2uPiaicUMp66vatdL+ZdMdZ+G1WTRb+6jFpY
	 4Zc9x9hQ22FxTp0Ef3bvxIma1bXPzw/7Q/j3eJHu/w+I6pPIAVGerOiVATpzrK0Qe8
	 7Y7/usdkSSVVyOWkWE7JZUGm5MdaVIfOjdqIx/+6CaPm0X1QVuMQBGh5suOmTGgx0z
	 HLbKVpaP2h5/Q==
Date: Wed, 3 Jul 2024 23:33:47 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/8] timers/migration: Rename childmask by groupmask
 to make naming more obvious
Message-ID: <ZoXDu9yt-o0OUMm7@pavilion.home>
References: <20240701-tmigr-fixes-v3-6-25cd5de318fb@linutronix.de>
 <20240703203115.9028-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240703203115.9028-1-anna-maria@linutronix.de>

Le Wed, Jul 03, 2024 at 10:31:15PM +0200, Anna-Maria Behnsen a écrit :
> childmask in the group reflects the mask that is required to 'reference'
> this group in the parent. When reading childmask, this might be confusing,
> as this suggests, that this is the mask of the child of the group.
> 
> Clarify this by renaming childmask in the tmigr_group and tmc_group by
> groupmask.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

