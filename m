Return-Path: <linux-kernel+bounces-418027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2BD9D5BFE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67D51F230E7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906D119DF8E;
	Fri, 22 Nov 2024 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFnVG9Jy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF21F165EE6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732267979; cv=none; b=Z2vUbk9BO31bpVpriIUxEbvWwPfTgNIxIylEcUoveU18qLjNhHt1/Zkcqunn5JqULmaYIMUF3l/eJKbrPUPsBfdv7goXUvQOhLJIyL4Vl9XRBJVgcv3B3bBeTlDsovZmtepaRb5d70JhXFNU6N4OJsU/eVtZtTab1e7muBzuMs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732267979; c=relaxed/simple;
	bh=T7xjCoT1gSzZczvGnuo2h0UKlSlVQBVAb2ODDoOJw7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVM8ytDoNeTOEWv+sxhzCsa3aS97AW+j3Sw7oxE/zB5QXPE+TSMebspLnZI/5IS3qaei0tEqu97K4sYNcCA9GZkdw0tpNj2Fm6Q+6+M6vipDdsq4kBeEBmUCRQCiN9dP8N7LQwq3kqqnUSulnIX9rZfcgLGG61z7vp6rica6BH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFnVG9Jy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834DAC4CECE;
	Fri, 22 Nov 2024 09:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732267978;
	bh=T7xjCoT1gSzZczvGnuo2h0UKlSlVQBVAb2ODDoOJw7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dFnVG9JydNxOkI9IcMrc6tSSTfPvRY820z//xZiXM4LRhOBK+QSHOpoFShEPZT8Rd
	 7X1GkaMEoMRoXSQPvfj4VZtQU3Bmt6+33MThK64Hravl8VsDY1j3xhbirZvVoeTQMy
	 H8dntZIOKz4lxxrDjyS0x06f5jixwX5pghf+nBhGsNn3nsXGfFWNjhMr59nzKYXK8d
	 YRYDHXuljFYtsK6WNv5G6svznNOCNI7zuEhNOixw0bP/fe9nGTPwraA5bki/fLUKYh
	 6X4TRI3IIrO7/mj5xJqgaPJtjU16MioxcQvwcGApzEHGyxLMhm8ihewj0UfDBzMxXI
	 urpExye60hXOA==
Date: Fri, 22 Nov 2024 10:32:53 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, <linux-kernel@vger.kernel.org>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 3/6] acpi/ghes: rename the function which gets hw error
 offsets
Message-ID: <20241122103253.1a1e7551@foz.lan>
In-Reply-To: <20241120143308.00005c31@huawei.com>
References: <cover.1731486604.git.mchehab+huawei@kernel.org>
	<3dccd08b82755bd42ab61408d5d86b2bfe2f2f01.1731486604.git.mchehab+huawei@kernel.org>
	<20241120143308.00005c31@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 20 Nov 2024 14:33:08 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> On Wed, 13 Nov 2024 09:37:00 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Rename: get_ghes_offsets->get_hw_error_offsets
> > to make clear that this function return offsets based on the
> > hardware error firmware.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

As there were changes at the cleanup series, I ended merging this one
there on patch 13/15:

	https://lore.kernel.org/qemu-devel/e5661a6383449675b28e15c8479ebca42c939368.1732266152.git.mchehab+huawei@kernel.org/T/#u
	
Thanks,
Mauro

