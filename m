Return-Path: <linux-kernel+bounces-416105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D019D412C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95D5B2FA15
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7581D153820;
	Wed, 20 Nov 2024 16:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="RlpOhZx8"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE9C13AA31;
	Wed, 20 Nov 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732120947; cv=none; b=cu0+gZd1C6fj+ZjNV53S1ioTtmAH2k9ohr+ckFpglHEA9gciTlV5YvoQrmfdTsIjokld4Alpf+n7p8mVA4n1nW3P5ZRt3r68VNxlnLuRYOvlJg9G3lxyccsH5QxigNewPqdpX52FhK4u0VV6H8E93kLjI9gbblskWu07YsQKuMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732120947; c=relaxed/simple;
	bh=lMdmD3iIf/wKJBbX1ynMWhrpijTBwJACgOnEacA3UQE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Km4E0DB81A9mnnTwzvjnWWm3ADexx7sLRZgoWPOE5zUm4jl0lFMAgrpsUtT2nyEdOyeBfYCtzgSR1nj5zZvyvCKvxxs8Au8aJhO+rMc0yqX5l/wVHsSjrFgREW/OXCzrrJslCNCqNCOgrWSs2d2NjyJhhss/gZCDBJ9/2tfacGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=RlpOhZx8; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732120931; x=1732725731; i=markus.elfring@web.de;
	bh=0Zh74NHczFEcZTK8YC8WqtvYRJoAmYRdaTT270uXa2U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RlpOhZx8wRCn1Z/gI/7gq0+AY4g6SbIbZelJ7LtZndt6HlzVuxpTjwnczzgpN2WT
	 f7OB2aH2VNK3X6twwkbLMZjNVeiXPlAMFYIP2Km0tU9D65vxwVYEVqyFoVsRpMvrW
	 c63bGGv1AeFuYY0wUDt/sK6wQgKJOtyLirhImk/4VvO373pGsJ+IdW7ExbWiTa0aa
	 l0jb4b5GXuVa/0KJPKkFGoUy0u/e3K9TRK3Y36Q1Z7Sq2Cq2YU69sM7jGKeJNaTTE
	 +7EDEdSrA/D5ILb6KrAi9daZyt3fjYTo9Iwt8AHjOmJ1J0gbokFk+lk9Av/49ESJl
	 fFCzY17IFq2voAdttQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrft2-1tYrNm42mi-00l3SW; Wed, 20
 Nov 2024 17:42:11 +0100
Message-ID: <84aeb85d-52da-43f2-bff2-715fc190b615@web.de>
Date: Wed, 20 Nov 2024 17:42:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Paolo Perego <pperego@suse.de>, linux-staging@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>, Dave Penkler <dpenkler@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kees Bakker <kees@ijzerbout.nl>
References: <20241120144653.377795-1-pperego@suse.de>
Subject: Re: [PATCH] staging: gpib: Fix a dereference before null check issue
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241120144653.377795-1-pperego@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4gVunDG9aRabZXFiD7YcvjnKWHiAcpNkZliPUPJ7dV5T2oLAc5Y
 NCD9K533LF0+p2mjm2YsH9YJQqwqTqdnIaYCx+Bn1/hhBowXLlMXzYUAekyrt+7m7nmWm2o
 9RK3qSDR4D2P8jH2iOIuzy4UPlvuqlbULc8M3sLYqBRC+5ql7vggzt8z3R6/Afo+7KqZ0OQ
 WfKXPj4p9SoQFqDzzVI1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lM655mtglAE=;tHf2BoXOvP1U7m7JZUcehu6aqN3
 oaFMMBXdokSStyqjPBrAs1CTZ4G4X8k/3h5EACGgHzOBY61mRelnCXGko1QjfsET9uaPrrzin
 H+mSfQQBEfPhk54zfcoKRMBfqoYf4rTiH3/n5iqw5Zrc577jDIgwauYKVN6y5VHghzWsy+VXt
 ne8GQcMbKF4VJ9txzzmHHtIMnb/HplOfWcv4WOdtl3i6WVleqZVotS7AmtEqVEUS0K4dP12VX
 2GoJt6Les54AmRwTKU6K7TlXXXAOelZ+FAcj0NSXmsthnFcBs5Oaav+GQ7fn/5t0YltL1AqXD
 Phqy3XerPSOh5JpZlmwi/yFVBP6YuVxqxhJHMVdDGc2bRtVnWmHg0OCZakBx9eOWVTJtkbO7S
 6k4mA/a7d8hXyM9guvp+dyW90sruxCQTcOXzAWHG5oD9UmB7L2bzSm6hPAns8FHyptI/cuFkC
 tUbvBSdmX5OpH0gCNbUxMhafG/lfy4ObQtyMz9BTfj71K/qPcO1SM3KMG/uoWe61MatHZIgSf
 YA9fWg846GBnlzDwGXBVfYbmOwRteNv78eLkvzD1+77U98oAz8yXi/uuoBUE95STZIFogGHr4
 m8WGJCkOj37gN9fY6/kiYb1SJ9TgPTojSs7nNNs1Viais4C0CK0jj55rYVaLJxwKovoC1ox+l
 yTahVEwYNDoiuo142/tuirsesyGpzxOOFxuKE5tDwNhaR4GCUaM9jRXCCHyj/hJtMVbCEp/+T
 sP69rJaqgDEvcRR4xTXE461ZcRW1aKSei9e6KClHRRDs/kTltPnK7pr8qGUJ5gJUual1jSw7T
 rGkaMHxKlB0QZ5u96Wr0dLaMVzEVAXVW430oZuvV0oThHVitc8P36a09NCjEs9tUwe1Adtf/h
 SkrlA3W5N7dV3SzLI7ojjdGLGf6jI5l24QAiYVzgalbhPtne0DgqlHAJ6hHNl1BdDg2Tzjheg
 Td1pvbxhLvaHU+pxJVQ7UNdjWIHyd3ljw8Xf007HGc8APVVMCsw9MLTUkQLQNDYTA4w5Lk7O1
 cNr+KVu2OYHDMslbWGiTtOEbOWnTZHZCLCEZjM3Ut+caskO9quk1wBTR3Ghlc+ggILxVAYNPy
 gpf/fZxQE=

=E2=80=A6
> The check ad line 1450 suggests that a_priv can be NULL, however it has

            at?


> been derefenced before, in the interface_to_usbdev() call.
=E2=80=A6

       dereferenced?


See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.12#n94

Regards,
Markus

