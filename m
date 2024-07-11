Return-Path: <linux-kernel+bounces-249444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B99492EBCF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEE2285DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760EE16C845;
	Thu, 11 Jul 2024 15:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGipjdoy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD6916C868
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712372; cv=none; b=dFLnWxp9hN+zvVZkVH8FGsArRKBMPscMpfH5YJEe1UXPXfT0F6mjv5jr5vl6Vt++Gi0SJJ0jp/4KEDDX+2/aBaeMbcIpJqfpbBPnBfrZK+gcwMC7x77V+yl2oiKbvJryItRLJ6YeverMfi8reGRyZB9D/VO2m2iCWrYojWxlgoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712372; c=relaxed/simple;
	bh=3LgOEGetljIxF7iOxu22EzFZvkhafiZYmXlPMvUuOjM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LhIa9nsTLNsqlPLoi2RA03tQxkOdk84WZLzno9HSGHPXL1kqNRzgjnbKuynpf/58qsBjuQkTWBaq5Lpaj3r/VLKBRjdggmAYw7BG9Rbrbrvh2SQZwyDfP6Q9DwvMPSJ7lr0EzKMC+bska9oWw5kR5csZF+kOtE7ifLvSrjgRAhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGipjdoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4EBC4AF0A;
	Thu, 11 Jul 2024 15:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720712371;
	bh=3LgOEGetljIxF7iOxu22EzFZvkhafiZYmXlPMvUuOjM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=QGipjdoypZZEIsIxzX6W0su0IlAmR7By6B+cDU7ouXrape2W+HWykSMXtKLpNOwW9
	 xqENEYuWHWbOnejcihxl5YA8cUV5BNl4+bFkc+Udj/OFuhx+u/2Vq3pg5z2IA0s9aH
	 91vZFNuDrlGl12d9Bcbt75UxSGDPBjH9Vo4STEPfrL1rOL0sePP7AVcvFndzRiVMyX
	 YYcfdQno+HEaApUpveLSGxPNW6M0bkn3Wy6CKo8/M5/PykrxM1R6UwtztQLZLOjGEh
	 WDbA9Ez3i0tIRh+YoQ0Dza+wU2YycxLSlkUZK3UUXSmz1ggz0fptfxmwDMwl1wruZp
	 qj2oAnLcIj+Dg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <ZoWg89A8C4gylTGX@google.com>
References: <ZoWg89A8C4gylTGX@google.com>
Subject: Re: (subset) [PATCH] mfd: timberdale: attach device properties to
 tsc2007 board info
Message-Id: <172071237016.1875446.17338144128047838915.b4-ty@kernel.org>
Date: Thu, 11 Jul 2024 16:39:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 03 Jul 2024 12:05:23 -0700, Dmitry Torokhov wrote:
> Switch over to using software nodes/properties to describe the
> touchscreen instead of using the legacy platform data. This will
> allow to drop support for the platform data from tsc2007 driver
> and rely solely on the generic driver properties.
> 
> Note: "model" is not part of defined device propertioes and is not
> used by the tsc2007 driver, so it can be safely dropped.
> 
> [...]

Applied, thanks!

[1/1] mfd: timberdale: attach device properties to tsc2007 board info
      commit: c298391abf6505c4040632b310a14f6bd9b7afff

--
Lee Jones [李琼斯]


