Return-Path: <linux-kernel+bounces-330187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B06A2979AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 07:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F70BB21FB9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80354210EE;
	Mon, 16 Sep 2024 05:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TFao5v7V"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3D717C6C
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726463917; cv=none; b=Y+qA+Xs3iI+1ES/rbDnXViMLmpT+jKjn6tUlxa3bB6tNDByIzjnQfO6sOctU6t4+uLdsfOzB8EhJfsz/YhnqQPpeThKuoxKxehVdK0trnoaOkFTyHJ/oSVVIu83L7NoFWR5RYbhf+ufS9hhMZ3gHih6DSNZ5uC44q83x/1F6lKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726463917; c=relaxed/simple;
	bh=IKD2m8kKnksZdBWr3CiOViYwXl2YPGLp/PvLK4Yj/AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=el8ca+d5TIz8i+7rdPsdlwm4NxAyF+ZlOftWAsKva8pOwkxEZnV4bwS/lzHruBW2N6nfENrfrUopB1N9c9H82tzUhHqGf5vWvIJs3cdPa0xw9mWlJG5HktOUrQuxyTGkAe7QNKzCfOv2NRc69igu8iTko7ffKgNm6qIeFCZdqKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TFao5v7V; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1726463904;
	bh=IKD2m8kKnksZdBWr3CiOViYwXl2YPGLp/PvLK4Yj/AA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=TFao5v7VdvKYXwDTMlwTadPztYjLWdtxPYkU/PaAkTqfW3RDwIV09wqWjHzfjBHfH
	 ks4RiVgac73x2T74DREXPzihEuv3+7D2agKpW9fs4TO3QBjRGqELVmXKFYGN056jJV
	 zAdt5Gv57aTAHseSj0E5RLgjJ2K+c8FZ4cphIrGo=
X-QQ-mid: bizesmtpip4t1726463697tms5hf6
X-QQ-Originating-IP: LGnQ9vyXoDDeis4iXE8VQtPfqcloeaihdOui9rlCmr4=
Received: from avenger-OMEN-by-HP-Gaming-Lapto ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 16 Sep 2024 13:14:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2861929487123837409
From: WangYuli <wangyuli@uniontech.com>
To: therealgraysky@proton.me
Cc: bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	x86@kernel.org,
	WangYuli <wangyuli@uniontech.com>
Subject: Re: [PATCH] x86: add more x86-64 micro-architecture levels
Date: Mon, 16 Sep 2024 13:14:49 +0800
Message-ID: <FF9779A964DEC399+20240916051449.126818-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me>
References: <W22JX8eWQctCiWIDKGjx4IUU4ZgYmKa1zPOZSKHHVZ74zpUEmVV1VoPMMNcyc-zhraUayW0d4d7OIUYZHuiEqllnAc1tB8DthZahsHZuw0Y=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

Yes, specifying '-march=x86-64-v3' can indeed yield significant performance improvements for CPUs that support it. I could confirm this.

Please allow me a few days, as I will provide a detailed test data report from my own tests after my vacation.

Given that such submissions 'pop up' in the mailing list from time to time, I hope this time we can see it through.

We should have a broad discussion, comprehensive testing and a calm judgment until we reach a final conclusion on whether this modification brings more benefits or drawbacks.

Link: https://github.com/graysky2/kernel_compiler_patch/issues/100
Suggested-by: WangYuli <wangyuli@uniontech.com>
Tested-by: WangYuli <wangyuli@uniontech.com>

Best regards,
--
WangYuli

