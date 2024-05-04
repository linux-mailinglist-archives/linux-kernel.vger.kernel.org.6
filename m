Return-Path: <linux-kernel+bounces-168522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D399D8BB987
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 07:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196AE1C21515
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 05:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777DEEAE7;
	Sat,  4 May 2024 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Iow4G1IE"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089DE28EA;
	Sat,  4 May 2024 05:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714800459; cv=none; b=pNKqtR9k2fSZJHbDolSQoBfLCn9MF1VPJNByXxuUVPzl9w6/UtXuMMoFrTrcwes8yOSsqjHIlopcDM4eqYesdKx6h1WWGl7w4uvE7TSYp6vRmp7lXO2bzeGl3Fpth5f6eZwdUN5ZtR2ERAAnq/sIo2wN8d52ij3vgpBjffunYcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714800459; c=relaxed/simple;
	bh=5CDRb/Kj/FXIGwwQtVRafh54AOF1teiJzYL6NPxuTQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMI0Ph3B5cutcG6tplZShs96TYnxHOtCLH0RU82thLmYklPY7oR0gEVEZUiKby2lHCAMUSGlv6Hc1c1jGdQZRmazow0dgx1+x2IAmdKHLJ+5BeNtDQ7ydciyuUdgsMnnDrdMgyFV7jv9i+NTKOCZsBGRFDgr3ZVfYaKsAJkFnz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Iow4G1IE; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714800448; x=1715405248; i=markus.elfring@web.de;
	bh=5CDRb/Kj/FXIGwwQtVRafh54AOF1teiJzYL6NPxuTQI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Iow4G1IEa9I81XODs2vGSqp0F2KjUDZosuYLqkp9fvWFfLXxJlswmw77bmFxAm2c
	 NHzc7NsG6TK31JW92XtKx6vvLaq7bhQYUUgspdKpqi3mAxRKmvU0pfORfh1pvAIpq
	 7un/9KdBI/4F63VZ38mBKiuJ0Fhq8GXfSiYNrWEhFjChJ7f8LvcDG3NsO9HkI/RQ0
	 yo2x2rVAmpiRK3x4f6eNFvqPNS5v95tRpQULWRB0m5ZV+WhWyf9MVJE27vpRmDk6q
	 Mrqd1CyYZnZxUrmKrNNqZn8U7nYlfK+JwK39/AL1eRZbgvDkPahOHvvXZ7ZiIQsAN
	 eH+GdY5n3eVWjs31EQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIc3F-1robVP2lAT-00EkY5; Sat, 04
 May 2024 07:13:30 +0200
Message-ID: <265db78b-1d69-4b12-a370-2589d8987833@web.de>
Date: Sat, 4 May 2024 07:12:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3 1/4] usb: typec: ucsi: Fix null pointer dereference in trace
To: Jameson Thies <jthies@google.com>,
 Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
 linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Benson Leung <bleung@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hdegoede@redhat.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Prashant Malani <pmalani@chromium.org>,
 Rajaram Regupathy <rajaram.regupathy@intel.com>,
 Saranya Gopal <saranya.gopal@intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
References: <20240503003920.1482447-2-jthies@google.com>
 <96d63b0b-3258-4bf6-b75a-06eb4f4253bb@web.de>
 <CAMFSARdhyWAFWr6qjsabPN6k=sK9LLxOaoSNkVLyTKNE=drSpg@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAMFSARdhyWAFWr6qjsabPN6k=sK9LLxOaoSNkVLyTKNE=drSpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:O9p1CtKBSIoiaiu6JgcG4x7X32MjQ1JzyCFYy/bs9oSN6q4n8OK
 6R1+uzJ96V8wkQqwL3UjPULceQGVyR2sVpmrNv+xKIVZQ6uiO1NHPRfL6U6hOS1z3m9+qbo
 CWvz2stVKIAnhyw1bfJV2LrADjI0umvPwY3u7kupYBP/5Mg6RVvrMMuQRtLwUT8E17gJ6Ge
 88whvLUYr+jJgtv8NaJzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M+MtCQmNi0Q=;7XYoUm86OmStWLuBVnCgNsTLKPE
 JhzMhKVYH+PEDuuBVet0kZ2FFfiaVeyBK/m98izfhJNMSpR5pX4jfbPVJmFgKz7djgCHe/mRZ
 4OLoVvx8SGYZf8kFC/uVPnGyzLtzpuMw4DPPZQBkBOME1r91M65LDx21PGvMqy9CP3MysxRCP
 HE5H/v8JtdbUBgAIrVT9zsoOuooiCnWKl/CpkrDWkX6zrOm5F8K1oyAgI+EL8G3vLtjbMsJAK
 vMLdaHnfDwCbhptiuF8C9eZVCIXgR/TCkV6ogsaXieFS5/g+qCRQ3dtze6ZVbJ9EM7iQxL4f2
 JaAAgZPHEFAx7uAoHm7GCrr4BfyU/37cXqMzOZpnVh+NuqsLIHeIqMZiaGqW9M4LYYN/BdjS+
 dYV+GvzFRdkAMYlByWaJLNk8NhZg962bPxEGjDHf+3pAzRwRpyOgNQmqYqDj2HZ3fvtoDyVLW
 ixG3CFLnU2rTx79zQG5MfmMlopDAFlowCLDkEz2xl5KKXr5wow0qIX24Sw+2qVS6N+HHJrgSc
 91oWsBftc0M+sNw8GhHnJJz5ABIOMMtTM8C1xJlyveCArwwXQ9VPZyLgalcMhZ/1RbMBYvqST
 otHErdkSmcPCVDJR55AG6COB8mVwfdC3SajChNIzqHIH8dmlRZBknpRGSFu7BqR3ELusRd9MM
 8Z2xHfrf/FXsD+aRSv3EtFNFCLVU2CxLC65SeLNuWY7gavUidgxk642CkWLaYwBO5ghHicZ/i
 hotIUIAPR5Dkm2otPoW4WDp96KrFkC8Xa2qq5QADuMX17lh3mGb6Qzf4nx4tz1UebBm3jg0CF
 4zQruhsHM1rgZ/r8HX0iD7bexb/odOapZoz9xPojIXC8EQ6yGXtliFiByAvkdHAKzS

> I don't think it is necessary to mention changes to the commit message
> in the section below the commit message.

Did you notice that other contributors occasionally share hints about
adjustments for parts of commit messages?
Will further information presentation become better supported?

Regards,
Markus

