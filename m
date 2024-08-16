Return-Path: <linux-kernel+bounces-289715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3531954AED
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA121F2388D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6791BA86D;
	Fri, 16 Aug 2024 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=hotelshavens.com header.i=admin@hotelshavens.com header.b="W/D+I6pI"
Received: from mail.hotelshavens.com (mail.hotelshavens.com [217.156.64.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957A1B9B29
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 13:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.156.64.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814478; cv=none; b=Q99ol8/fmHNnm4Ei8NUeAZo9JDrPbQJYaUSMuz6dIPa0uVth1rnezw53FulJ++ydF20SBc0lTPxxT5NCdqWAm+GnajV0cnuAcVxwWTa4BNJPiWQzoNu67ElZYAOYOqlDvForNAhQGSGEMdzpUox0pC7p8Y7VARYKuhSeNnkbjSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814478; c=relaxed/simple;
	bh=LFBNAW6W9KSP/XA+nSyjySzgtwDAkCVpCRsmRip3XzA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VnmyOhVhcOdgiHzS6TjnmAlayVAY+jBFDIuEJD6ncjI5Voz9hwgM/7KYtO3067qyVC+QhEELAV2ZnRWvcKDclX7i0NdrrhaNFy4z6zicPYDQpc8Uhleq20pZcOyoL5z2hJWtU5z/4yY0LmQ+rhuyhX6nZ//6fwAiHgJbTUVGASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotelshavens.com; spf=pass smtp.mailfrom=hotelshavens.com; dkim=pass (4096-bit key) header.d=hotelshavens.com header.i=admin@hotelshavens.com header.b=W/D+I6pI; arc=none smtp.client-ip=217.156.64.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotelshavens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotelshavens.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=dkim; d=hotelshavens.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=admin@hotelshavens.com;
 bh=LFBNAW6W9KSP/XA+nSyjySzgtwDAkCVpCRsmRip3XzA=;
 b=W/D+I6pI0HwLU8Ethk8JygsnIe8mAZNGqaFbaKA2pykQAKRjGlmnUmUR+xqa6jljp166EAeIwXn4
   t2K2BU6Xyga4JK8ia488jSX2eZigNXyMd+bUl/QOs9PmYE/z5TjENKXzEqvl6Bc8+vy4xRbrtehq
   6Mcu9xgm00LQ9pXSk1D64Wvu6WvNJK/UtXDiWOtJIU9P7o295/8N5NaftfKsRnecSzz+3W80fTPp
   T/sv5ZbSSL8PWsMIZzlImgYPOzHj5c1j8z66nmQcsZPSe+GCoVyVshVzsNJPNIxVbMMfC5IRxCeH
   Z9EmHy8Q0/6+DBKF4cqKHG5VtCby/JxRl2y4sPtZdKwvVM1XUmVTZF7feI1uGTvdYoNdkDQjJxwR
   xIo8ocr0SJ+xwAQNTIRw2fvHJ/070wNG6E9i1bCzF+4XLkvWq2RfBXSVtahM13JnZDM9iHbAlRlh
   ysf80nD/R4sFOTtJ2uL/2dIzEjdG3o0iOkbGPdssqOVeWzZSp2Vj8JbVEMPMiFWE789x2QNy//OV
   g5LQJNqmDrhj3HtmShCBBwWKablZJV0rXT+hSZufGzvEZ7NWXY2HzKi4eq3rKRRrByxdiEfMnVeo
   8eDMkIpvCv9Tu9v3og2kSIC9azPYMcdMcRA4vVL1W5jDeF7aDjDCUt+BvtKuK6gIlP5/7MXoZ64=
Reply-To: boris@undpkh.com
From: Boris Soroka <admin@hotelshavens.com>
To: linux-kernel@vger.kernel.org
Subject: HI DEAR !
Date: 16 Aug 2024 15:14:12 +0200
Message-ID: <20240816134828.DEA293A612776C75@hotelshavens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Greetings,

Did you receive my last email message I sent to this Email=20
address: ( linux-kernel@vger.kernel.org ) concerning relocating=20
my investment to your country due to the on going war in my=20
country Russia.

Best Regards,
Mr.Boris Soroka.

